{ inputs, ... }: {
  perSystem = { pkgs, system, ... }:
    let
      setup = [
        {
          name = "Checkout code";
          uses = "actions/checkout@v4";
        }
        {
          name = "Install Nix";
          uses = "DeterminateSystems/nix-installer-action@main";
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
          name = "Use Cachix store";
          uses = "cachix/cachix-action@v14";
          "with" = {
            name = "tilde";
            authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            extraPullNames = "tilde,nix-community";
          };
        }
      ];

      workflow = {
        name = "CI";
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
          buildRemote = {
            name = "Build remote home configuration";
            runs-on = "ubuntu-latest";
            steps = setup ++ [{
              run = ''
                nix build .#homeConfigurationsPortable.x86_64-linux.remote.activation-script --keep-going --print-build-logs --show-trace --verbose
              '';
            }];
          };
          buildSystem = {
            name = "Build system";
            runs-on = "\${{ matrix.os }}";
            strategy = {
              matrix = {
                host = [ "eMac" "st-eturkeltaub2" ];
                os = [ "macos-14" ];
              };
            };
            steps = setup ++ [{
              run = ''
                nix build .#darwinConfigurations.''${{ matrix.host }}.system --keep-going --print-build-logs --show-trace --verbose
              '';
            }];
          };
          buildDevShell = {
            name = "Build devShell";
            runs-on = "macos-14";
            steps = setup ++ [{
              run = ''
                nix build .#devShells.aarch64-darwin.default --impure --keep-going --print-build-logs --show-trace --verbose
              '';
            }];
          };
        };
      };

      ci = inputs.nixago.lib.${system}.make {
        data = workflow;
        output = ".github/workflows/ci.yml";
        format = "yaml";
        hook.mode = "copy";
      };
    in {
      apps = {
        generate-ci.program = pkgs.writeShellScriptBin "generate-ci" ''
          ${ci.shellHook}
        '';
      };
    };
}
