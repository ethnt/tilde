{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ delta ];

  programs.git = {
    enable = true;

    settings = let
      delta = lib.getExe pkgs.delta;
      git = lib.getExe config.programs.git.package;
      fzf = lib.getExe pkgs.fzf;
      gh = lib.getExe pkgs.gh;
      superprune = pkgs.writeShellScript "git-alias-superprune" ''
        echo 'Fetching remote then deleting branches that are gone. This may take a moment'

        ${git} fetch -p

        gone=$(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')
        for branch in $gone; do
          ${git} branch -D $branch;
        done;
      '';
      co = pkgs.writeShellScript "git-alias-co" ''
        ${git} checkout "$(${git} branch --sort="-committerdate" | ${fzf} | tr -d '[:space:]')";
      '';
      wipe = pkgs.writeShellScript "git-alias-wipe" ''
        ${git} add .
        ${git} stash
      '';
    in {
      user.name = "Ethan Turkeltaub";

      alias = {
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
