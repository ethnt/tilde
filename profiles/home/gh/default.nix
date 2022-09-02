{ config, ... }: {
  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      editor = "${config.programs.vscode.package}/bin/code --wait";
    };
  };
}
