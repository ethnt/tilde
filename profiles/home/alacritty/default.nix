{
  programs.alacritty = let
    paleNight = {
      primary = {
        background = "0x292d3e";
        foreground = "0xd0d0d0";
      };

      normal = {
        black = "0x292d3e";
        red = "0xf07178";
        green = "0xc3e88d";
        yellow = "0xffcb6b";
        blue = "0x82aaff";
        magenta = "0xc792ea";
        cyan = "0x89ddff";
        white = "0xd0d0d0";
      };

      bright = {
        black = "0x434758";
        red = "0xff8b92";
        green = "0xddffa7";
        yellow = "0xffe585";
        blue = "0x9cc4ff";
        magenta = "0xe1acff";
        cyan = "0xa3f7ff";
        white = "0xffffff";
      };
    };
    solarizedDark = {
      primary = {
        background = "0x002b36";
        foreground = "0x839496";
      };

      normal = {
        black = "0x073642";
        red = "0xdc322f";
        green = "0x859900";
        yellow = "0xb58900";
        blue = "0x268bd2";
        magenta = "0xd33682";
        cyan = "0x2aa198";
        white = "0xeee8d5";
      };

      bright = {
        black = "0x002b36";
        red = "0xcb4b16";
        green = "0x586e75";
        yellow = "0x657b83";
        blue = "0x839496";
        magenta = "0x6c71c4";
        cyan = "0x93a1a1";
        white = "0xfdf6e3";
      };
    };
    nord = {
      primary = {
        background = "0x2E3440";
        foreground = "0xD8DEE9";
      };

      normal = {
        black = "0x3B4252";
        red = "0xBF616A";
        green = "0xA3BE8C";
        yellow = "0xEBCB8B";
        blue = "0x81A1C1";
        magenta = "0xB48EAD";
        cyan = "0x88C0D0";
        white = "0xE5E9F0";
      };

      bright = {
        black = "0x4C566A";
        red = "0xBF616A";
        green = "0xA3BE8C";
        yellow = "0xEBCB8B";
        blue = "0x81A1C1";
        magenta = "0xB48EAD";
        cyan = "0x8FBCBB";
        white = "0xECEFF4";
      };
    };
    font = "PragmataPro Mono Liga";
  in {
    enable = true;
    settings = {
      window = { padding = { x = 9; }; };
      font = {
        normal = { family = font; };
        bold = {
          family = font;
          style = "Bold";
        };
        italic = {
          family = font;
          style = "Italic";
        };
        bold_italic = {
          family = font;
          style = "Bold Italic";
        };
        offset = { y = 6; };
        size = 18;
        use_thin_strokes = true;
      };
      cursor = {
        style = "block";
        blinking = "On";
      };
      colors = nord;
    };
  };
}
