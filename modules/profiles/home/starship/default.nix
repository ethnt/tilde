{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    # enableFishIntegration = true;
    settings = { character = { success_symbol = "[➜](bold green)"; }; };
  };

  programs.fish.interactiveShellInit = ''
    # starship
    ${pkgs.starship}/bin/starship init fish
  '';
}
