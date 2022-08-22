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
  format = runCodeAnalysis "format" ''
    ${pkgs.nixfmt}/bin/nixfmt --check ${self}/**/*.nix
  '';

  lint = runCodeAnalysis "lint" ''
    ${pkgs.statix}/bin/statix check ${self}
  '';
}
