{ suites, ... }: {
  imports = with suites; base ++ development ++ programming ++ identity;

  tilde.home = {
    username = "ethan";
    homeDirectory = "/Users/ethan";
    gpg = { keyId = "0x690FEBBF6380166A"; };
  };

  # home.username = "ethan";
  # home.homeDirectory = "/Users/ethan";
  home.stateVersion = "23.05";
}
