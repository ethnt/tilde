{ pkgs }:

pkgs.writeShellApplication {
  name = "update-tilde";
  runtimeInputs = with pkgs; [ nix ];
  text = ''
    exec "$(nix build github:ethnt/tilde#homeConfigurationsPortable.${pkgs.system}.remote.activation-script --accept-flake-config --no-link --print-out-paths)/activate"
  '';
}
