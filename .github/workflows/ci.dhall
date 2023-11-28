let GithubActions = https://regadas.dev/github-actions-dhall/package.dhall

let checkout =
      GithubActions.Step::{
      , name = Some "Checkout code"
      , uses = Some "actions/checkout@v2.4.0"
      }

let installNix =
      GithubActions.Step::{
      , name = Some "Install Nix"
      , uses = Some "cachix/install-nix-action@v23"
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

let magicCache =
      GithubActions.Step::{
      , name = Some "Use Magic Nix Cache"
      , uses = Some "DeterminateSystems/magic-nix-cache-action@main"
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
            nix flake -Lv check --impure --show-trace
          ''
      }

let buildRemoteHomeConfiguration =
      GithubActions.Step::{
      , run = Some
          ''
            nix build .#homeConfigurationsPortable.x86_64-linux.remote.activation-script --print-build-logs --show-trace --verbose
          ''
      }

let activateHomeConfiguration =
      GithubActions.Step::{
      , run = Some
          ''
            export USER=eturkeltaub

            mkdir /home/eturkeltaub
            export HOME=/home/eturkeltaub

            ./result/activate
          ''
      }

let setup = [ checkout, installNix, magicCache, cachix, sshKeys, unlockSecrets ]

in  GithubActions.Workflow::{
    , name = "CI"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { check = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.macos-latest
          , steps = setup # [ check ]
          }
        , buildRemote = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps =
                setup
              # [ buildRemoteHomeConfiguration, activateHomeConfiguration ]
          }
        }
    }
