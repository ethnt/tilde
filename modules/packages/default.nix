{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { config, pkgs, ... }: {
    overlayAttrs = {
      inherit (config.packages)
        mcp-remote nix-docker oh-my-tmux postgres-mcp sf-pro;
    };

    packages = {
      mcp-remote = pkgs.callPackage ./mcp-remote.nix { };
      nix-docker = pkgs.callPackage ./nix-docker.nix { };
      oh-my-tmux = pkgs.callPackage ./oh-my-tmux.nix { };
      postgres-mcp = pkgs.callPackage ./postgres-mcp.nix { };
      sf-pro = pkgs.callPackage ./fonts/sf-pro.nix { };
    };
  };
}
