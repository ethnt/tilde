let GithubActions =
      https://raw.githubusercontent.com/regadas/github-actions-dhall/master/package.dhall

let checkout =
      GithubActions.Step::{
      , name = Some "Checkout code"
      , uses = Some "actions/checkout@v3"
      }

let installNix =
      GithubActions.Step::{
      , name = Some "Install Nix"
      , uses = Some "DeterminateSystems/nix-installer-action@main"
      , `with` = Some (toMap { extra-conf = "system-features = aarch64-linux" })
      }

let sshKeys =
      GithubActions.Step::{
      , name = Some "Add SSH key to ssh-agent"
      , uses = Some "webfactory/ssh-agent@v0.8.0"
      , `with` = Some
          ( toMap
              { ssh-private-key =
                  ''
                    ''${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}
                    ''${{ secrets.SECRETS_DEPLOY_KEY}}
                  ''
              }
          )
      }

let unlockSecrets =
      GithubActions.Step::{
      , name = Some "Unlock encrypted files"
      , run = Some
          ''
            nix-env -i git-crypt -f '<nixpkgs>'
            echo "''${{ secrets.GIT_CRYPT_KEY }}" | base64 -d > /tmp/git-crypt-key
            git-crypt unlock /tmp/git-crypt-key
            rm /tmp/git-crypt-key
          ''
      }

let cachix =
      GithubActions.Step::{
      , name = Some "Use Cachix store"
      , uses = Some "cachix/cachix-action@v12"
      , `with` = Some
          ( toMap
              { name = "tilde"
              , authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}"
              , extraPullNames = "tilde,nix-community,nrdxp"
              }
          )
      }

let check =
      GithubActions.Step::{
      , run = Some
          ''
            nix flake -Lv check --impure --all-systems --show-trace
          ''
      }

let homeManagerSystemMatrix = toMap { system = [ "x86_64-linux" ] }

let darwinHostMatrix =
      toMap
        { os = [ "flyci-macos-large-latest-m1" ]
        , host = [ "eMac", "st-eturkeltaub2" ]
        }

let setup = [ checkout, installNix, cachix, sshKeys ]

in  GithubActions.Workflow::{
    , name = "CI"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { check = GithubActions.Job::{
          , name = Some "Check flake"
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps = setup # [ check ]
          }
        , buildRemote = GithubActions.Job::{
          , name = Some "Build remote home configuration"
          , strategy = Some GithubActions.Strategy::{
            , matrix = homeManagerSystemMatrix
            }
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps =
                setup
              # [ GithubActions.Step::{
                  , run = Some
                      ''
                        nix build -j4 --option system ''${{ matrix.system }} --extra-platforms ''${{ matrix.system }} .#homeConfigurationsPortable.''${{ matrix.system }}.remote.activation-script --accept-flake-config --print-build-logs --show-trace --verbose
                      ''
                  }
                ]
          }
        , buildSystem = GithubActions.Job::{
          , name = Some "Build system"
          , strategy = Some GithubActions.Strategy::{
            , matrix = darwinHostMatrix
            }
          , runs-on = GithubActions.RunsOn.Type.`${{ matrix.os }}`
          , steps =
                setup
              # [ GithubActions.Step::{
                  , run = Some
                      ''
                        nix develop --impure --accept-flake-config -c "just" "build-system" "''${{ matrix.host }}"
                      ''
                  }
                ]
          }
        }
    }
