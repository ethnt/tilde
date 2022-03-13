{
  nix.binaryCaches = [
    "https://cachix.org/api/v1/cache/tilde"
    "https://nrdxp.cachix.org"
    "https://cachix.org/api/v1/cache/nix-community"
    "https://cache.nixos.org/"
  ];

  nix.binaryCachePublicKeys = [
    "tilde.cachix.org-1:S40KIZfILOgYgbcGhZ/V6h+PVe8ywbMtRdXy3nmYr4U="
    "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
}
