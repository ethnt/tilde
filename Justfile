host := `hostname -s`
username := env_var('USER')

nix_flags := "--print-build-logs --show-trace --verbose"
nix_build_flags := "--keep-going"
darwin_flags := "--flake ."
nixos_flags := "--flake . --use-remote-sudo"

os_command := if os() == "macos" {
  "darwin-rebuild"
} else if os() == "linux" {
  "nixos-rebuild"
} else {
  "unknown"
}

os_config := if os() == "macos" {
  ".#darwinConfigurations.\"" + host + "\".config.system.build.toplevel"
} else if os() == "linux" {
  ".#nixosConfigurations.\"" + host + "\".config.system.build.toplevel"
} else {
  ".#unknown"
}

home_config := ".#homeConfigurations.aarch64-darwin." + username + ".activationPackage"

default: build

build: build-all

build-all:
	nix {{ nix_flags }} build {{ nix_build_flags }} {{ os_config }} {{ home_config }}

build-home:
	nix {{ nix_flags }} build {{ nix_build_flags }} --out-link result-home {{ home_config }}

switch-host:
  {{ os_command }} switch {{ darwin_flags }}

switch-home: build-home
  ./result-home/activate

switch: switch-host switch-home
