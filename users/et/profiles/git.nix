{ config, ... }: {
  programs.git = {
    userEmail = "et@mercury.com";
    userName = "Ethan Turkeltaub";
    signing.key = "F8E4DBB3201AFD1E";
  };
}
