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

  programs.starship = {
    settings = {
      hostname = { style = "bold dimmed"; };

      "custom.remote-name" = { command = "echo $remote_name"; };
    };
  };
}
