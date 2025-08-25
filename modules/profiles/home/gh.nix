{ config, lib, ... }: {
  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      editor = "${lib.getExe config.programs.vscode.package} --wait";
    };
  };
}
