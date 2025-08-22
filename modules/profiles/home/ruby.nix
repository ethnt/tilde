{ pkgs, ... }: {
  home.packages = with pkgs; [
    rubyPackages_3_4.solargraph
    zlib
    libyaml
    libffi
  ];

  home.file.".gemrc".text = ''
    gem: --no-document
  '';
}
