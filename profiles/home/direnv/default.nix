{ pkgs, lib, ... }: {
  programs.direnv = {
    enable = true;
    stdlib = ''
      use_flake() {
        watch_file flake.nix
        watch_file flake.lock
        eval "$(${pkgs.nix}/bin/nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
      }
    '';
  };
}
