let GithubActions = https://regadas.dev/github-actions-dhall/package.dhall

let checkout = GithubActions.Step::{ uses = Some "actions/checkout@v2.4.0" }

let installNix =
      GithubActions.Step::{ uses = Some "cachix/install-nix-action@v16" }

let sshKeys =
      GithubActions.Step::{
      , uses = Some "webfactory/ssh-agent@v0.5.4"
      , `with` = Some
          (toMap { ssh-private-key = "\${{ secrets.PRAGMATAPRO_DEPLOY_KEY }}" })
      }

let unlockSecrets =
      GithubActions.steps.run
        { run =
            ''
              echo "''${{ secrets.GIT_CRYPT_KEY }}" | base64 -d > /tmp/git-crypt-key
              nix develop -c "git-crypt" "unlock" "/tmp/git-crypt-key"
              rm /tmp/git-crypt-key
            ''
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
                        "nix -Lv build .#darwinConfigurations.\${{ matrix.host }}.system --show-trace"
                    }
                ]
          }
        }
    }
