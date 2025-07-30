{ suites, ... }: {
  imports = with suites; base ++ development;

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
  };

  home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";

    stateVersion = "24.05";
  };

  programs = {
    git = {
      userEmail = "ethan@turkeltaub.dev";
      userName = "Ethan Turkeltaub";
    };
  };
}
