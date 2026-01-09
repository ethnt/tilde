{ pkgs, ... }: {
  home.packages = [ pkgs.jj-starship ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      character.success_symbol = "[➜](bold green)";

      git_branch.disabled = true;
      git_status.disabled = true;

      custom.jj = {
        when = "jj-starship detect";
        shell = [ "jj-starship" ];
        format = "$output ";
      };
    };
  };
}
