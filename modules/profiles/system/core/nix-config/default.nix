{ config, pkgs, ... }: {
  sops = {
    secrets.nix-conf-github-pat = { sopsFile = ./secrets.json; };

    templates."nix/nix-conf-access-tokens" = {
      content = ''
        access-tokens = github.com=${config.sops.placeholder.nix-conf-github-pat}
      '';
      mode = "0777";
    };
  };

  nixpkgs = {
    # NOTE: This relies on all hosts having the same `system`. If a system comes along that is different, this cannot
    # be set to the flake-wide `pkgs`, as it is here: https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-nixpkgs.pkgs
    inherit pkgs;

    flake = {
      setFlakeRegistry = true;
      setNixPath = true;
    };
  };

  nix = {
    extraOptions =
      "!include ${config.sops.templates."nix/nix-conf-access-tokens".path}";
    gc.automatic = true;
  };

}
