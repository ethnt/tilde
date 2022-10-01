let nixCommand = λ(cmd : Text) → "/nix/var/nix/profiles/default/bin/nix ${cmd}"

in  { task.timeout = "120m"
    , macos_instance.image = "ghcr.io/cirruslabs/macos-monterey-base:latest"
    , matrix =
      [ { name = "build"
        , environment =
          { CIRRUS_USER_PERMISSION = "admin"
          , CACHIX_AUTH_TOKEN =
              "ENCRYPTED[7e00c3086fa51a56acd871027b2e32003e93224b6bc0b978d39ef1b05bc65a458c71c8a6663b508a19eeba05560b37e3]"
          , GIT_CRYPT_TOKEN =
              "ENCRYPTED[415884b4c6e8e899e8808b433a8fc0c153f095c6fef7db2963b7ab0110bd53b9d79e5d37a7543987f34290c7c8c70686]"
          }
        , install_script =
          [ "sh <(curl -L https://nixos.org/nix/install)"
          , "mkdir -p \$HOME/.config/nix"
          , "echo \"extra-experimental-features = nix-command flakes\" >> \$HOME/.config/nix/nix.conf"
          , "echo \"trusted-users = admin\" >> \$HOME/.config/nix/nix.conf"
          ]
        , git-crypt_unlock_script =
          [ "echo \"\$GIT_CRYPT_TOKEN\" | base64 -d > /tmp/git-crypt-key.asc"
          , "brew install git-crypt"
          , "git-crypt unlock /tmp/git-crypt-key.asc"
          , "git add ."
          ]
        , build_script =
          [ nixCommand
              "build .#darwinConfigurations.st-eturkeltaub2.system --show-trace"
          ]
        }
      ]
    }
