{ suites, ... }: {
  imports = with suites; base ++ development;

  tilde.home = {
    username = "et";
    homeDirectory = "/Users/et";
  };

  home = {
    username = "et";
    homeDirectory = "/Users/et";

    stateVersion = "24.05";
  };

  programs = {
    git = {
      userEmail = "et@mercury.com";
      userName = "Ethan Turkeltaub";
    };
  };
}
