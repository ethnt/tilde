{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = { be = "bundle exec"; };
    shellInit = ''
      # fish
      set -U fish_prompt_pwd_dir_length 0

      # nix
      set -g PATH /run/current-system/sw/bin $HOME/.nix-profile/bin /etc/profiles/per-user/**/bin $PATH
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
      name = "sponge";
      src = pkgs.fetchFromGitHub {
        owner = "andreiborisov";
        repo = "sponge";
        rev = "0f3bf8f10b81b25d2b3bbb3d6ec86f77408c0908";
        sha256 = "EUT9Bf+OD+cCNLfJqVog4kSXSNfuT5Db/+ejwsRBUW8=";
      };
    }];
  };
}
