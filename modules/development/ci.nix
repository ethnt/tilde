{ self, inputs, ... }:
let l = inputs.nixpkgs.lib // builtins;
in {
  imports = [ inputs.actions-nix.flakeModules.default ];

  flake.actions-nix.workflows = let
    actions = {
      checkout = "actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd";
      install-lix =
        "samueldr/lix-gha-installer-action@7b7f14d320d6aacfb65bd1ef761566b3b69e474c";
      ssh-agent =
        "webfactory/ssh-agent@e83874834305fe9a4a2997156cb26c5de65a8555";
      attic = "ryanccn/attic-action@1887fd507f03327c96c64cca30118c96eb17fdad";
      cachix = "cachix/cachix-action@1eb2ef646ac0255473d23a5907ad7b04ce94065c";
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
            ''${{ secrets.SECRETS_DEPLOY_KEY }}"
            ''${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}"
          '';
        };
      }
      {
        name = "Setup Attic cache";
        uses = actions.attic;
        "with" = {
          cache = "e10";
          endpoint = "https://cache.e10.camp";
          token = "\${{ secrets.ATTIC_TOKEN }}";
        };
      }
      {
        name = "Use Cachix store";
        uses = actions.cachix;
        "with" = {
          authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
          installCommand =
            "nix profile install github:NixOS/nixpkgs/nixpkgs-unstable#cachix";
          name = "e10";
        };
      }
    ];
  in {
    ".github/workflows/check.yml" = {
      name = "Check flake";
      jobs = {
        check = {
          name = "Check flake";
          runs-on = "ubuntu-latest";
          steps = setup ++ [{
            name = "Run check flake";
            run = "nix flake -Lv check --impure --show-trace";
          }];
        };
      };
    };

    ".github/workflows/build.yml" = {
      name = "Build system";
      jobs = {
        build-system = {
          name = "Build system";
          runs-on = "ubuntu-latest";
          strategy.matrix.host = l.attrNames self.darwinConfigurations;
          steps = setup ++ [
            {
              name = "Clean up storage";
              run = ''
                sudo rm -rf /usr/share/dotnet /usr/local/lib/android /opt/ghc /opt/hostedtoolcache/CodeQL
                sudo docker image prune --all --force
                sudo docker builder prune -a
              '';
            }
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

    ".github/workflows/devshell.yml" = {
      name = "devShell";
      jobs = {
        build-dev-shell = {
          name = "Build devShell";
          runs-on = "macos-15";
          steps = setup ++ [{
            name = "Build aarch64-darwin shell";
            run =
              "nix build .#devShells.aarch64-darwin.default --impure --keep-going --print-build-logs --show-trace --verbose";
          }];
        };
      };
    };
  };
}
