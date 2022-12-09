{ channels, config, lib, pkgs, suites, ... }:

with lib;

{
  imports = with suites; minimal;

  tilde.home = {
    username = "eturkeltaub";
    homeDirectory = "/home/eturkeltaub";
    gpg = { keyId = "4FF658525A04B618E0376A8854CFB5EB45626324"; };
  };

  programs.git = { signing.key = config.tilde.home.gpg.keyId; };

  programs.fish = {
    plugins = [{
      name = "sushi";
      src = pkgs.fetchFromGitHub {
        owner = "umayr";
        repo = "theme-sushi";
        rev = "2bd0236872de5c05f9eab7840cc90f836dd0e3c6";
        sha256 = "kKd2DADh1rerfwA/Da+/43xi8U8JYaWVvyS4vReGcIM=";
      };
    }];
  };
}
