{ config, pkgs, lib, ... }: {
  # home.packages = [ pkgs.gnupg ];

  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      # https://dave.wittman.xyz/posts/yubikey-not-working-macos-big-sur-gpg-23/
      disable-ccid = true;
    };

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
      keyid-format = "0 xlong";
      list-options = "show-uid-validity verify-options show-uid-validity";
      "with-fingerprint" = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };
  };

  home.file.".gnupg/gpg-agent.conf" = { source = ./gpg-agent.conf; };

  programs.fish = let package = config.programs.gpg.package;
  in {
    shellInit = let gpgconf = "${package}/bin/gpgconf";
    in lib.mkAfter ''
      # GPG
      export GPG_TTY=(tty)
      export SSH_AUTH_SOCK=(${gpgconf} --list-dirs agent-ssh-socket)
      export KEYID=0x690FEBBF6380166A
      ${gpgconf} --launch gpg-agent
    '';

    functions = lib.mkAfter {
      switch_yubikey = let gpg = "${package}/bin/gpg";
      in ''
        set keygrips (${gpg} --with-keygrip --list-secret-keys $KEYID | grep Keygrip | awk '{print $3}')
        for keygrip in $keygrips
          rm "$HOME/.gnupg/private-keys-v1.d/$keygrip.key" 2> /dev/null
        end

        ${gpg} --card-status
      '';

      fix_gpg = "${package}/bin/gpg-connect-agent updatestartuptty /bye";
    };
  };
}
