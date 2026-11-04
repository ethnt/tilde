{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.ghostty-bin;
    settings = {
      adjust-cell-height = 10;
      cursor-style = "bar";
      font-family = "PragmataPro Mono Liga";
      font-size = 16;
      theme = "nord";
      macos-option-as-alt = true;

      # Lets fish (or anything in the terminal) handle `Alt + arrow`
      keybind = [
        "alt+arrow_left=unbind"
        "alt+arrow_right=unbind"
      ];

      window-padding-x = 8;
      confirm-close-surface = false;
    };
  };
}
