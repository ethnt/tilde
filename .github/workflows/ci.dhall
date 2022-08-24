let GithubActions = https://regadas.dev/github-actions-dhall/package.dhall

let checkout =
      GithubActions.Step::{
      , name = Some "Checkout code"
      , uses = Some "actions/checkout@v2.4.0"
      }

let installNix =
      GithubActions.Step::{
      , name = Some "Install Nix"
      , uses = Some "cachix/install-nix-action@v16"
      , `with` = Some (toMap { nix_path = "nixpkgs=channel:nixos-unstable" })
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
      , name = Some "Unlock with git-crypt"
      , uses = Some "sliteteam/github-action-git-crypt-unlock@1.2.0"
      , env = Some (toMap { GIT_CRYPT_KEY = "\${{ secrets.GIT_CRYPT_KEY }}" })
      }

let cachix =
      GithubActions.Step::{
      , uses = Some "cachix/cachix-action@v10"
      , `with` = Some
          ( toMap
              { name = "tilde"
              , authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}"
              }
          )
      }

let setup = [ checkout, installNix, sshKeys, unlockSecrets, cachix ]

in  GithubActions.Workflow::{
    , name = "CI"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { check = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.macos-latest
          , steps =
                setup
              # [ GithubActions.steps.run
                    { run =
                        ''
                        nix flake -Lv check --show-trace
                        ''
                    }
                ]
          }
        , build = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.macos-latest
          , strategy = Some GithubActions.Strategy::{
            , matrix = toMap { host = [ "eMac", "st-eturkeltaub1" ] }
            }
          , steps =
                setup
              # [ GithubActions.steps.run
                    { run =
                        ''
                        nix-shell -p git-crypt --command "nix -Lv build .#darwinConfigurations.''${{ matrix.host }}.system --show-trace"
                        ''
                    }
                ]
          }
        }
    }
