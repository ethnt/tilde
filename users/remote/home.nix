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
      name = "simple-ass-prompt";
      src = pkgs.fetchFromGitHub {
        owner = "lfiolhais";
        repo = "theme-simple-ass-prompt";
        rev = "b2d3ed234a0f9528369f5dc6452e2b1c6ca1b23e";
        sha256 = "lAXUQg/gcgmVMxGO0eFnMsAk6L79YsZwSvyXvoLTCuo=";
      };
    }];
  };
}
