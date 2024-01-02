{ pkgs, ... }: { home.packages = with pkgs; [ ffmpeg youtube-dl ]; }
