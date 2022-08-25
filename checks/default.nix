{ self, pkgs }:
let
  hostChecks =
    builtins.mapAttrs (_: config: config.config.system.build.toplevel)
    self.darwinConfigurations;
  runCodeAnalysis = name: command:
    pkgs.runCommand "tilde-${name}-check" { } ''
      cd ${self}
      mkdir $out
      ${command}
    '';
in hostChecks // {
  nix-format = runCodeAnalysis "nix-format" ''
    ${pkgs.nixfmt}/bin/nixfmt --check **/*.nix
  '';

  dhall-format = runCodeAnalysis "dhall-format" ''
    ${pkgs.dhall}/bin/dhall format --check **/*.dhall
  '';

  toml-format = runCodeAnalysis "toml-format" ''
    ${pkgs.taplo-cli}/bin/taplo fmt --check **/*.toml
  '';

  lint = runCodeAnalysis "lint" ''
    ${pkgs.statix}/bin/statix check ${self}
  '';
}
