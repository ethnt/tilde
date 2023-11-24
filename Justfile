os_command := "darwin-rebuild"

nix_flags := "--print-build-logs --show-trace --verbose"
darwin_flags := "--flake .#"
build_flags := "--keep-going"


default:
  @just --list

build:
  {{ os_command }} build {{ darwin_flags }} {{ nix_flags }} {{ build_flags }}

switch:
  {{ os_command }} switch {{ darwin_flags }}
