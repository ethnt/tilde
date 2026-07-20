{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      be = "bundle exec";
      gph = "git push origin HEAD";
      gphf = "git push origin HEAD -f";
    };

    interactiveShellInit = ''
      # fish prompt configuration
      set -U fish_prompt_pwd_dir_length 0

      # fish color configuration
      set -g fish_color_autosuggestion 555 brblack

      # any-nix-shell
      ${lib.getExe pkgs.any-nix-shell} fish --info-right | source
    '';

    functions.fish_greeting = "";

    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "b693237c3027b81ac3760d60d159d2be4925ed1c";
          hash = "sha256-JyAFxYkPQZs4TfVfBVPKa202SXsAZCyCLzVW+6/PASA=";
        };
      }
    ];
  };
}
