{ config, ... }: {
  sops = {
    defaultSopsFile = ../../../secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
