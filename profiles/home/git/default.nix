{ pkgs, ... }: {
  home.packages = with pkgs; [ delta hub ];

  programs.git = {
    enable = true;

    aliases = let
      superprune = pkgs.writeShellScript "git-alias-superprune" ''
        echo 'Fetching remote then deleting branches that are gone. This may take a moment'

        git fetch -p

        gone=$(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}')
        for branch in $gone; do
          git branch -D $branch;
        done;
      '';
      co = pkgs.writeShellScript "git-alias-co" ''
        git checkout "$(git branch --sort="-committerdate" | ${pkgs.fzf}/bin/fzf | tr -d '[:space:]')";
      '';
    in {
      s = "status";
      superprune = "!sh ${superprune}";
      co = "!sh ${co}";
    };

    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    signing.signByDefault = true;

    extraConfig = let deltaCommand = "${pkgs.delta}/bin/delta";
    in {
      core = {
        pager = deltaCommand;
        preloadindex = true;
        deltabasecachelimit = "4g";
      };
      interactive.diffFilter =
        "${deltaCommand} --diff-so-fancy --keep-plus-minus-markers --line-numbers";
      feature = { manyfiles = true; };
      fetch = { prune = true; };
      http = { sslCAinfo = "/etc/ssl/certs/ca-certificates.crt"; };
    };
  };
}
