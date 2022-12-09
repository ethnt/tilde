{ channels, config, lib, pkgs, suites, ... }:

with lib;

{
  imports = with suites; minimal;

  tilde.home = {
    username = "eturkeltaub";
    homeDirectory = "/home/eturkeltaub";
    gpg = { keyId = "4FF658525A04B618E0376A8854CFB5EB45626324"; };
  };

  programs.git.signing.key = config.tilde.home.gpg.keyId;

  programs.starship.settings = {
    format = "$username$env_var$all";

    env_var.remote_name = {
      format = "[$env_value]($style) in ";
      style = "bold fg:#859900";
    };

    username.format = "[$user]($style) on ";

    aws.disabled = true;
    hostname.disabled = true;
    gcloud.disabled = true;
    nodejs.disabled = true;
    openstack.disabled = true;
    ruby.disabled = true;
  };
}
