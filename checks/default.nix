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
    ${pkgs.nixfmt}/bin/nixfmt --check ${self}/**/*.nix
  '';

  dhall-format = runCodeAnalysis "dhall-format" ''
    ${pkgs.dhall}/bin/dhall format --check **/*.dhall
  '';

  editorconfig-chcker = runCodeAnalysis "editorconfig-checker" ''
    ${pkgs.editorconfig-checker}/bin/editorconfig-checker
  '';

  lint = runCodeAnalysis "lint" ''
    ${pkgs.statix}/bin/statix check ${self}
  '';
}
