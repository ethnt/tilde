{ inputs, ... }: {
  perSystem = { pkgs, system, ... }:
    let
      setup = [
        {
          name = "Checkout code";
          uses = "actions/checkout@v3";
        }
        {
          name = "Install Nix";
          uses = "DeterminateSystems/nix-installer-action@main";
          "with" = {
            extra-conf = ''
              system-features = big-parallel
              extra-platforms = aarch64-linux
              accept-flake-config = true
            '';
          };
        }
        {
          name = "Add SSH keys to ssh-agent";
          uses = "webfactory/ssh-agent@v0.8.0";
          "with" = {
            ssh-private-key = ''
              ''${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}
              ''${{ secrets.SECRETS_DEPLOY_KEY }}
            '';
          };
        }
        {
          name = "Use Cachix store";
          uses = "cachix/cachix-action@v12";
          "with" = {
            name = "tilde";
            authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            extraPullNames = "tilde,nix-community,nrdxp";
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
                nix build -j4 --option system x86_64-linux --extra-platforms x86_64-linux .#homeConfigurationsPortable.x86_64-linux.remote.activation-script --print-build-logs --show-trace --verbose
              '';
            }];
          };
          buildRemoteAarch64 = {
            name = "Build remote home configuration (aarch64)";
            runs-on = "ubuntu-latest";
            steps = setup ++ [{
              run = ''
                nix build -j4 --option system aarch64-linux --extra-platforms aarch64-linux .#homeConfigurationsPortable.aarch64-linux.remote.activation-script --print-build-logs --show-trace --verbose
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
                nix develop --impure -c "just" "build-system" "''${{ matrix.host }}"
              '';
            }];
          };
          buildDevShell = {
            name = "Build devShell";
            runs-on = "macos-14";
            steps = setup ++ [{
              run = ''
                nix build -j4 .#devShells.aarch64-darwin.default --impure --print-build-logs --show-trace --verbose
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
