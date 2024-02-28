{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      be = "bundle exec";
      gph = "git push origin HEAD";
      gphf = "git push origin HEAD -f";
    };

    shellInit = ''
      # fish prompt configuration
      set -U fish_prompt_pwd_dir_length 0

      # fish color configuration
      set -g fish_color_autosuggestion 555 brblack
    '';

    interactiveShellInit = ''
      function __fish_command_not_found_handler --on-event="fish_command_not_found"
        ${pkgs.bashInteractive}/bin/bash -c \
          "source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh; command_not_found_handle $argv"
      end
    '';

    functions = {
      fish_greeting = "";
      find_nix_package = "fd $argv /nix/store -d 1 -t d | head -n 1";
    };

    plugins = [{
      name = "foreign-env";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "plugin-foreign-env";
        rev = "7f0cf099ae1e1e4ab38f46350ed6757d54471de7";
        sha256 = "4+k5rSoxkTtYFh/lEjhRkVYa2S4KEzJ/IJbyJl+rJjQ=";
      };
    }];
  };
}
