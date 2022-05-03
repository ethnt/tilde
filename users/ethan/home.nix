{ config, lib, pkgs, suites, ... }:

with lib;

{
  imports = with suites; (base ++ development ++ identity);

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg = { keyId = "0x690FEBBF6380166A"; };
  };

  home.sessionVariables = { KEYID = config.tilde.home.gpg.keyId; };

  programs.git = {
    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";
    signing.key = config.tilde.home.gpg.keyId;
  };
}
