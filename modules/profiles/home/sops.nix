{ config, ... }: {
  sops = {
    defaultSopsFile = ../../../secrets.json;
    defaultSopsFormat = "json";
    defaultSymlinkPath = "${config.xdg.dataHome}/secrets";

    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
  };
}
