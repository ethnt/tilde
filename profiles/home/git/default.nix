{
  programs.git = {
    enable = true;

    aliases = { "s" = "status"; };
    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    delta.enable = true;
  };
}
