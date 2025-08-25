##: helpers
hostname := `hostname`

##: binary cache
cachix-cache-name := "tilde"
attic-cache-name := "tilde"
cache-jobs := "5"

default:
    @just --list

[doc("Builds the current host")]
build: (build-system hostname)

[doc("Build a host by name")]
build-system name:
    nh darwin build .#darwinConfigurations.{{ name }} --out-link result

[doc("Build a specific home-manager user")]
build-home name:
    nom build .#homeConfigurationsPortable.{{ name }}.activation-script --print-build-logs --show-trace --verbose --keep-going

[doc("Switch to the current host profile")]
switch: (move-rc-files)
    nh darwin switch .#

[doc("Check flake")]
check:
    nix flake check --impure --all-systems

[doc("Open a Nix REPL for this flake")]
repl:
    nix repl .#

[doc("Format code")]
format:
    treefmt

[doc("Push the `result` to the binary caches")]
push-result-to-cache: (push-to-cache "result")

[doc("Push an arbitrary path to the binary caches")]
push-to-cache path:
    cachix push --jobs {{ cache-jobs }} {{ cachix-cache-name }} {{ path }}
    attic push --jobs {{ cache-jobs }} {{ attic-cache-name }} {{ path }}

[doc("Move `bashrc` and `zshrc` files so they don't get clobbered")]
move-rc-files:
    sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
    sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
