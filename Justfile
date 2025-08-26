hostname := `hostname`
username := `whoami`

cachix-cache-name := "tilde"
attic-cache-name := "tilde"
cache-jobs := "5"

nh-build-flags := "--out-link result"

default:
    @just --list

[doc("Builds the current host")]
build: (build-system hostname)

[doc("Build a host by name")]
build-system name:
    nh darwin build .#darwinConfigurations.{{ name }} {{ nh-build-flags }}

[doc("Build a specific home-manager user")]
build-home name:
    nh home build .#homeConfigurations.{{ name }}.activation-script {{ nh-build-flags }}

[doc("Switch to the current host profile")]
switch:
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
