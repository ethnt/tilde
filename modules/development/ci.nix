{ self, inputs, ... }: {
  perSystem = { pkgs, lib, system, ... }:
    let
      setup = [
        {
          name = "Checkout code";
          uses = "actions/checkout@v4";
        }
        {
          name = "Install Nix";
          uses = "DeterminateSystems/nix-installer-action@v14";
          "with" = {
            extra-conf = ''
              system-features = big-parallel
              accept-flake-config = true
            '';
          };
        }
        {
          name = "Add SSH keys to ssh-agent";
          uses = "webfactory/ssh-agent@v0.9.0";
          "with" = {
            ssh-private-key = ''
              ''${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}
              ''${{ secrets.SECRETS_DEPLOY_KEY }}
            '';
          };
        }
        {
          name = "Setup Attic cache";
          uses = "ryanccn/attic-action@v0";
          "with" = {
            endpoint = "https://cache.e10.camp";
            cache = "tilde";
            token = "\${{ secrets.ATTIC_TOKEN }}";
          };
        }
        {
          name = "Use Cachix store";
          uses = "cachix/cachix-action@master";
          "with" = {
            authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            name = "tilde";
            installCommand =
              "nix profile install github:NixOS/nixpkgs/nixpkgs-unstable#cachix";
            extraPullNames = "tilde,nix-community";
          };
        }
      ];

      checkWorkflow = {
        name = "Check flake";
        on.push = { };
        jobs = {
          check = {
            name = "Check flake";
            runs-on = "ubuntu-latest";
            steps = setup ++ [{
              run = ''
                nix flake -Lv check --impure --show-trace
              '';
            }];
          };
        };
      };

      buildWorkflow = {
        name = "Build outputs";
        on.push = { };
        jobs = {
          buildDevShell = {
            name = "Build devShell";
            runs-on = "macos-14";
            steps = setup ++ [{
              run = ''
                nix build .#devShells.aarch64-darwin.default --impure --keep-going --print-build-logs --show-trace --verbose
              '';
            }];
          };
          buildSystem = {
            name = "Build system";
            "runs-on" = "\${{ matrix.os }}";
            strategy.matrix = {
              host = lib.attrNames self.darwinConfigurations;
              os = [ "macos-14" ];
            };
            steps = setup ++ [{
              name = "Build \${{ matrix.host }} host";
              run = ''
                nix build .#darwinConfigurations.''${{ matrix.host }}.system --keep-going --print-build-logs --show-trace --verbose
              '';
            }];
          };
        };
      };

      nixagoMake = inputs.nixago.lib.${system}.make;

      check = nixagoMake {
        data = checkWorkflow;
        output = ".github/workflows/check.yml";
        format = "yaml";
        hook.mode = "copy";
      };

      build = nixagoMake {
        data = buildWorkflow;
        output = ".github/workflows/build.yml";
        format = "yaml";
        hook.mode = "copy";
      };
    in {
      apps = {
        generate-ci.program = pkgs.writeShellScriptBin "generate-ci" ''
          ${check.shellHook}
          ${build.shellHook}
        '';
      };
    };
}
