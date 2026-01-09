{ pkgs, ... }: {
  home.packages = [ pkgs.jj-starship ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = ''
        $username$hostname$directory$custom$elixir$erlang$golang$nodejs$ruby$terraform$nix_shell$cmd_duration$status
        $character
      '';

      character.success_symbol = "[➜](bold green)";

      git_branch.disabled = true;
      git_status.disabled = true;

      nix_shell.symbol = "❄️ ";

      custom.jj = {
        when = "jj-starship detect";
        shell = [ "jj-starship" ];
        format = "$output ";
      };
    };
  };
}
