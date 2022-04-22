{ config, lib, pkgs, suites, ... }: {
  imports = with suites; base;

  tilde.home = { username = "ci"; };
}
