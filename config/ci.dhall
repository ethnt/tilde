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
      , `with` = Some
          ( toMap
              { nix_path = "nixpkgs=channel:nixos-unstable"
              , extra_nix_config =
                  "system-features = nixos-test benchmark big-parallel kvm"
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
            echo "''${{ secrets.GIT_CRYPT_KEY }}" | base64  -d > /tmp/git-crypt-key
            git-crypt unlock /tmp/git-crypt-key
            rm /tmp/git-crypt-key
          ''
      }

let cachix =
      GithubActions.Step::{
      , name = Some "Use Cachix store"
      , uses = Some "cachix/cachix-action@v10"
      , `with` = Some
          ( toMap
              { name = "tilde"
              , authToken = "\${{ secrets.CACHIX_AUTH_TOKEN }}"
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

let build =
      GithubActions.Step::{
      , run = Some
          ''
            nix -Lv build .#darwinConfigurations.''${{ matrix.host }}.system --show-trace
          ''
      }

let setup = [ checkout, installNix, cachix, sshKeys, unlockSecrets ]

in  GithubActions.Workflow::{
    , name = "CI"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { check = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.macos-latest
          , steps = setup # [ check ]
          }
        , build = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.macos-latest
          , strategy = Some GithubActions.Strategy::{
            , matrix = toMap { host = [ "eMac", "st-eturkeltaub1" ] }
            }
          , steps = setup # [ build ]
          }
        }
    }