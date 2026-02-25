{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ delta ];

  programs.git = {
    enable = true;

    settings = let delta = lib.getExe pkgs.delta;
    in {
      user.name = "Ethan Turkeltaub";

      alias = let
        gh = lib.getExe pkgs.gh;
        mkGitShellScript = { name, text, extraRuntimeInputs ? [ ] }:
          lib.getExe (pkgs.writeShellApplication {
            inherit name text;

            runtimeInputs = [ config.programs.git.package ]
              ++ extraRuntimeInputs;
          });
        superprune = mkGitShellScript {
          name = "git-alias-superprune";
          text = ''
            echo 'Fetching remote then deleting branches that are gone. This may take a moment'

            git fetch -p

            gone=$(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')
            for branch in $gone; do
              git branch -D "$branch";
            done;
          '';
        };
        co = mkGitShellScript {
          name = "git-alias-co";
          extraRuntimeInputs = [ pkgs.fzf ];
          text = ''
            git checkout "$(git branch --sort="-committerdate" | fzf | tr -d '[:space:]')";
          '';
        };
        wipe = mkGitShellScript {
          name = "git-alias-wipe";
          text = ''
            git add .
            git stash
          '';
        };
      in {
        s = "status";
        superprune = "!sh ${superprune}";
        co = "!sh ${co}";
        wipe = "!sh ${wipe}";
        sync = "!${gh} repo sync";
      };

      core.pager = delta;

      interactive.diffFilter = "${delta} --color-only";

      http = { sslCAinfo = "/etc/ssl/certs/ca-certificates.crt"; };

      color = {
        status = "always";
        diff = "always";
      };

      init.defaultBranch = "main";
    };

    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    signing.signByDefault = config.programs.git.signing.key != null;
  };
}
