let GithubActions = https://regadas.dev/github-actions-dhall/package.dhall

let checkout =
      GithubActions.Step::{
      , name = Some "Checkout code"
      , uses = Some "actions/checkout@v2.4.0"
      }

let installNix =
      GithubActions.Step::{
      , name = Some "Install Nix"
      , uses = Some "cachix/install-nix-action@v20"
      , `with` = Some
          ( toMap
              { nix_path = "nixpkgs=channel:nixos-unstable"
              , extra_nix_config =
                  ''
                    allow-import-from-derivation = true
                  ''
              }
          )
      }

let sshKeys =
      GithubActions.Step::{
      , name = Some "Add SSH key to ssh-agent"
      , uses = Some "webfactory/ssh-agent@v0.5.4"
      , `with` = Some
          (toMap { ssh-private-key = "\${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}" })
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
            nix flake -Lv check --show-trace
          ''
      }

let buildHost =
      GithubActions.Step::{
      , run = Some
          ''
            nix -Lv build .#darwinConfigurations.''${{ matrix.host }}.system --show-trace
          ''
      }

let buildRemoteProfile =
      GithubActions.Step::{
      , run = Some
          ''
            nix -Lv build .#homeConfigurationsPortable.x86_64-linux.remote.activation-script --show-trace
          ''
      }

let format =
      GithubActions.Step::{
      , run = Some
          ''
            nix run .#test-format
          ''
      }

let lint =
      GithubActions.Step::{
      , run = Some
          ''
            nix run .#test-lint
          ''
      }

let setup = [ checkout, installNix, cachix, sshKeys, unlockSecrets ]

in  GithubActions.Workflow::{
    , name = "CI"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { code = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.macos-latest
          , steps = setup # [ format, lint ]
          }
        , hosts = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.`${{ matrix.os }}`
          , strategy = Some GithubActions.Strategy::{
            , matrix = toMap { host = [ "eMac" ], os = [ "macos-latest" ] }
            }
          , steps = setup # [ buildHost ]
          }
        , remote-profile = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.`ubuntu-20.04`
          , steps = setup # [ buildRemoteProfile ]
          }
        }
    }
