{ config, ... }: {
  programs.git = {
    userEmail = "ethan@turkeltaub.dev";
    userName = "Ethan Turkeltaub";
    signing.key = "0x690FEBBF6380166A";
  };
}
