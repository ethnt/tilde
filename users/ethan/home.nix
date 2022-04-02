{ config, lib, pkgs, suites, ... }: {
  imports = with suites; (base ++ development);

  programs.git = {
    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";
  };
}
