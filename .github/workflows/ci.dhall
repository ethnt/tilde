let GithubActions = https://regadas.dev/github-actions-dhall/package.dhall

let checkout =
      GithubActions.Step::{
      , name = Some "Checkout code"
      , uses = Some "actions/checkout@v2.4.0"
      }

let installNix =
      GithubActions.Step::{
      , name = Some "Install Nix"
      , uses = Some "DeterminateSystems/nix-installer-action@main"
      , `with` = Some
          (toMap { extra-conf = "system-features = aarch64-linux arm-linux" })
      }

let sshKeys =
      GithubActions.Step::{
      , name = Some "Add SSH key to ssh-agent"
      , uses = Some "webfactory/ssh-agent@v0.8.0"
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
            nix flake -Lv check --impure --all-systems --show-trace
          ''
      }

let homeManagerSystemMatrix =
      toMap { system = [ "x86_64-linux", "aarch64-linux" ] }

let setup = [ checkout, installNix, cachix, sshKeys, unlockSecrets ]

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
                        nix build -j4 --option system ''${{ matrix.system }} --extra-platforms ''${{ matrix.system }} .#homeConfigurationsPortable.''${{ matrix.system }}.remote.activation-script --print-build-logs --show-trace --verbose
                      ''
                  }
                ]
          }
        }
    }
