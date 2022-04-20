{ config, lib, pkgs, suites, ... }: {
  imports = with suites; (base ++ development);

  home.username = "ethan";
  home.homeDirectory = "/Users/ethan";

  home.sessionVariables = { KEYID = "0x690FEBBF6380166A"; };

  programs.git = {
    userEmail = "ethan.turkeltaub@hey.com";
    userName = "Ethan Turkeltaub";
    signing.key = "0x690FEBBF6380166A";
  };

  programs.gpg = {
    publicKeys = [{
      text = ''
        -----BEGIN PGP PUBLIC KEY BLOCK-----

        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
        =Fz30
        -----END PGP PUBLIC KEY BLOCK-----
      '';
      trust = "ultimate";
    }];
  };
}
