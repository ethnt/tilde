{
  programs.git = {
    enable = true;

    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";

    aliases = { "s" = "status"; };
    ignores = [ "*~" "#*#" ".elc" ".#*" "flycheck_*.el" ".projectile" ];

    delta.enable = true;
  };
}
