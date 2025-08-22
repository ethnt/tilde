{ pkgs, ... }: {
  home.packages = with pkgs; [ corepack nodePackages_latest.nodejs ];
}
