{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";
  };
}
