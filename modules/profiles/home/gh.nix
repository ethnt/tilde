{ config, lib, pkgs, ... }: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-poi gh-stack ];
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      editor = "${lib.getExe config.programs.zed-editor.package} --wait";
    };
  };

  programs.gh-dash.enable = true;
}
