{ suites, ... }: {
  imports = with suites; base;

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
  };

  # home.username = "ethan";
  # home.homeDirectory = "/Users/ethan";
  home.stateVersion = "23.05";
}
