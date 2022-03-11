{ config, lib, pkgs, ... }: {
  system.defaults = {
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };

    LaunchServices = { LSQuarantine = false; };

    dock = {
      show-recents = false;
      autohide = false;
      orientation = "bottom";
    };

    finder = {
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = false;
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
    };
  };
}
