{
  programs.fish.shellInit = ''
    if set -q GHOSTTY_RESOURCES_DIR
      source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    end
  '';

  xdg.configFile."ghostty/config".text = ''
    adjust-cell-height = 10
    cursor-style = bar
    font-family = PragmataPro Mono Liga
    font-size = 16
    theme = nord
    window-padding-x = 8
  '';
}
