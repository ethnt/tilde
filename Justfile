nix_flags := "--print-build-logs --show-trace --verbose"
nix_build_flags := "--keep-going"
darwin_flags := "--flake .#"
nixos_flags := "--flake . --use-remote-sudo"

os_command := if os() == "macos" {
  "nix run nix-darwin --"
} else if os() == "linux" {
  "nixos-rebuild"
} else {
  "unknown"
}

default: build

build:
  {{ os_command }} build {{ darwin_flags }} {{ nix_flags }} {{ nix_build_flags }}

switch:
  {{ os_command }} switch {{ darwin_flags }}
