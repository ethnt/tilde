{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { config, pkgs, ... }: {
    overlayAttrs = {
      inherit (config.packages)
        nix-docker oh-my-tmux sf-pro gh-stack mcp-remote;
    };

    packages = {
      gh-stack = pkgs.callPackage ./gh-stack.nix { };
      mcp-remote = pkgs.callPackage ./mcp-remote.nix { };
      nix-docker = pkgs.callPackage ./nix-docker.nix { };
      oh-my-tmux = pkgs.callPackage ./oh-my-tmux.nix { };
      sf-pro = pkgs.callPackage ./fonts/sf-pro.nix { };
    };
  };
}
