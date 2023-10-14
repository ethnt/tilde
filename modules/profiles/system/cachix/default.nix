{
  nix.settings.substituters = [
    "https://cachix.org/api/v1/cache/tilde"
    "https://cachix.org/api/v1/cache/nix-community"
    "https://cache.nixos.org/"
  ];

  nix.settings.trusted-public-keys = [
    "tilde.cachix.org-1:S40KIZfILOgYgbcGhZ/V6h+PVe8ywbMtRdXy3nmYr4U="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
}
