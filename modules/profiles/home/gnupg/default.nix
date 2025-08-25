{ pkgs, lib, ... }: {
  programs.gpg = {
    enable = true;

    scdaemonSettings = {
      # https://dave.wittman.xyz/posts/yubikey-not-working-macos-big-sur-gpg-23/
      disable-ccid = true;
    };

    mutableKeys = true;
    mutableTrust = true;

    settings = {
      # https://github.com/drduh/config/blob/master/gpg.conf
      # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration-Options.html
      # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Esoteric-Options.html
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list =
        "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      list-options = "show-uid-validity";
      "with-fingerprint" = true;
      verify-options = "show-uid-validity";
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };

    publicKeys = [{
      source = ./key.pub;
      trust = "ultimate";
    }];
  };

  home.file.".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;

  # This has to be set here, even though gpg-agent in nix-darwin should be able to set it
  home.sessionVariables.SSH_AUTH_SOCK =
    "$(${lib.getExe' pkgs.gnupg "gpgconf"} --list-dirs agent-ssh-socket)";
}
