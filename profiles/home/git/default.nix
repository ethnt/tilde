{ pkgs, ... }: {
  home.packages = with pkgs; [ hub ];

  programs.git = {
    enable = true;

    aliases = {
      "s" = "status";
      fza =
        "!git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 git add";
    };
    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    delta.enable = true;

    signing.signByDefault = true;

    extraConfig = {
      http = { sslCAinfo = "/etc/ssl/certs/ca-certificates.crt"; };
    };
  };
}
