{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ fish ];

  environment.shells = with pkgs; [ fish bashInteractive ];
}
