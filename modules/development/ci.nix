{ self, inputs, ... }:
let
  l = inputs.nixpkgs.lib // builtins;
in
{
  imports = [ inputs.actions-nix.flakeModules.default ];

  flake.actions-nix.workflows =
    let
      actions = {
        checkout = "actions/checkout@v7.0.1";
        install-lix = "samueldr/lix-gha-installer-action@v2026-06-15";
        ssh-agent = "webfactory/ssh-agent@v0.10.0";
        attic = "ryanccn/attic-action@v0.5.0";
        cachix = "cachix/cachix-action@v17";
      };
      setup = [
        {
          name = "Checkout code";
          uses = actions.checkout;
        }
        {
          name = "Install Lix";
          uses = actions.install-lix;
          "with" = {
            extra_nix_config = ''
              accept-flake-config = true
              max-jobs = auto
            '';
          };
        }
        {
          name = "Add SSH keys to ssh-agent";
          uses = actions.ssh-agent;
          "with" = {
            ssh-private-key = ''
              ''${{ secrets.SECRETS_DEPLOY_KEY }}
              ''${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}
            '';
          };
        }
        {
          name = "Setup Attic cache";
          uses = actions.attic;
          "with" = {
            cache = "tilde";
            endpoint = "https://cache.e10.camp";
            token = "\${{ secrets.ATTIC_TOKEN }}";
          };
        }
        {
          name = "Use Cachix store";
          uses = actions.cachix;
          "with" = {
            authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            installCommand = "nix profile install github:NixOS/nixpkgs/nixpkgs-unstable#cachix";
            name = "tilde";
          };
        }
      ];
    in
    {
      ".github/workflows/check.yml" = {
        name = "Check";
        jobs = {
          check = {
            name = "Check flake";
            runs-on = "ubuntu-latest";
            steps = setup ++ [
              {
                name = "Run check flake";
                run = "nix flake -Lv check --impure --show-trace";
              }
            ];
          };
        };
      };

      ".github/workflows/hosts.yml" = {
        name = "Host configurations";
        jobs = {
          build-system = {
            name = "Build host system";
            runs-on = "macos-15";
            strategy.matrix.host = l.attrNames self.darwinConfigurations;
            steps = setup ++ [
              {
                name = "Build \${{ matrix.host }} host system";
                run = ''
                  nix build .#darwinConfigurations.''${{ matrix.host }}.system --keep-going --print-build-logs --show-trace --verbose
                '';
              }
            ];
          };
        };
      };

      ".github/workflows/packages.yml" = {
        name = "Build packages";
        on.push.paths = [
          ".github/**/*.yml"
          "modules/packages/**/*.nix"
          "flake.lock"
        ];
        jobs = {
          build-package = {
            name = "Build package";
            runs-on = "macos-15";
            strategy.matrix = {
              architecture = [ "aarch64-darwin" ];
              package = l.filter (name: name != "render-workflows") (l.attrNames self.packages.aarch64-darwin);
            };
            steps = setup ++ [
              {
                name = "Build \${{ matrix.package }} (\${{ matrix.architecture }}) package";
                run = ''
                  nix build .#packages.''${{ matrix.architecture }}.''${{ matrix.package }} --keep-going --print-build-logs --show-trace --verbose
                '';
              }
            ];
          };
        };
      };

      ".github/workflows/devshell.yml" = {
        name = "devShell";
        jobs = {
          build-dev-shell = {
            name = "Build devShell";
            runs-on = "macos-15";
            steps = setup ++ [
              {
                name = "Build aarch64-darwin shell";
                run = "nix build .#devShells.aarch64-darwin.default --impure --keep-going --print-build-logs --show-trace --verbose";
              }
            ];
          };
        };
      };
    };
}
