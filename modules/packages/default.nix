{ inputs, ... }: {
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem = { config, pkgs, ... }: {
    overlayAttrs = {
      inherit (config.packages)
        firehydrant-mcp
        mcp-remote
        oh-my-tmux
        postgres-mcp
        sf-pro
        ;
    };

    packages = {
      firehydrant-mcp = pkgs.callPackage ./firehydrant-mcp { };
      mcp-remote = pkgs.callPackage ./mcp-remote { };
      oh-my-tmux = pkgs.callPackage ./oh-my-tmux { };
      postgres-mcp = pkgs.callPackage ./postgres-mcp { };
      sf-pro = pkgs.callPackage ./fonts/sf-pro { };
    };
  };
}
