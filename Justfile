os_command := "darwin-rebuild"
nix_flags := "--print-build-logs --show-trace --verbose"
darwin_flags := "--flake .#"
build_flags := "--keep-going"
hostname := `hostname`

default:
    @just --list

build: (build-system hostname)

build-system name:
    nix build .#darwinConfigurations.{{ name }}.system {{ nix_flags }} {{ build_flags }}

switch:
    {{ os_command }} switch {{ darwin_flags }}

generate-ci:
    nix run .#generate-ci

update-input input:
    nix flake lock --update-input {{ input }}

check:
    nix flake check --impure --all-systems

repl:
    nix repl --extra-experimental-features repl-flake .#

format:
    treefmt
