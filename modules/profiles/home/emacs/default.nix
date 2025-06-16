{ pkgs, ... }:
let
  configuredEmacs = pkgs.emacs.override {
    # BUG: https://github.com/NixOS/nixpkgs/issues/395169
    # withNativeCompilation = true;
    withTreeSitter = true;
  };
  patchedEmacs = configuredEmacs.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (pkgs.fetchpatch {
        url =
          "https://github.com/d12frosted/homebrew-emacs-plus/raw/refs/heads/master/patches/emacs-30/system-appearance.patch";
        sha256 = "3QLq91AQ6E921/W9nfDjdOUWR8YVsqBAT/W9c1woqAw=";
      })
      (pkgs.fetchpatch {
        url =
          "https://github.com/d12frosted/homebrew-emacs-plus/raw/refs/heads/master/patches/emacs-30/round-undecorated-frame.patch";
        sha256 = "uYIxNTyfbprx5mCqMNFVrBcLeo+8e21qmBE3lpcnd+4=";
      })
      (pkgs.fetchpatch {
        url =
          "https://github.com/d12frosted/homebrew-emacs-plus/raw/refs/heads/master/patches/emacs-28/fix-window-role.patch";
        sha256 = "+z/KfsBm1lvZTZNiMbxzXQGRTjkCFO4QPlEK35upjsE=";
      })
    ];
  });
in {
  programs.emacs = {
    enable = true;
    package = patchedEmacs;
  };

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    coreutils
    fd
    fontconfig
    shellcheck
    clang
  ];
}
