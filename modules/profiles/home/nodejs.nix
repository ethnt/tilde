{ pkgs, ... }: { home.packages = with pkgs; [ corepack nodejs_24 ]; }
