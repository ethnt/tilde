{ config, pkgs, ... }: {
  home.packages = with pkgs; [ delta hub ];

  programs.git = {
    enable = true;

    aliases = let
      gitCommand = "${config.programs.git.package}/bin/git";
      fzfCommand = "${pkgs.fzf}/bin/fzf";
      superprune = pkgs.writeShellScript "git-alias-superprune" ''
        echo 'Fetching remote then deleting branches that are gone. This may take a moment'

        ${gitCommand} fetch -p

        gone=$(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')
        for branch in $gone; do
          ${gitCommand} branch -D $branch;
        done;
      '';
      co = pkgs.writeShellScript "git-alias-co" ''
        ${gitCommand} checkout "$(${gitCommand} branch --sort="-committerdate" | ${fzfCommand} | tr -d '[:space:]')";
      '';
      wipe = pkgs.writeShellScript "git-alias-wipe" ''
        ${gitCommand} add .
        ${gitCommand} stash
      '';
    in {
      s = "status";
      superprune = "!sh ${superprune}";
      co = "!sh ${co}";
      wipe = "!sh ${wipe}";
    };

    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    signing = {
      signByDefault = true;
      key = config.tilde.home.gpg.keyId;
    };

    extraConfig = let deltaCommand = "${pkgs.delta}/bin/delta";
    in {
      core.pager = deltaCommand;
      interactive.diffFilter =
        "${deltaCommand} --diff-so-fancy --keep-plus-minus-markers --line-numbers";
      http = { sslCAinfo = "/etc/ssl/certs/ca-certificates.crt"; };
    };
  };
}
