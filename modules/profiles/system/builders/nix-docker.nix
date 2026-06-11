# NOTE: Also need to add to /var/root/.ssh/config, see nix-docker's README

{ config, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [ nix-docker ];

    etc = {
      "nix/docker_rsa" = {
        enable = true;
        source = "${pkgs.nix-docker}/ssh/insecure_rsa";
        mode = "0400";
      };

      "nix/remote-build-env" = {
        enable = true;
        source = "${pkgs.nix-docker}/ssh/remote-build-env";
      };
    };
  };

  nix.buildMachines = [{
    hostName = "nix-docker";
    systems = [ "x86_64-linux" ];
    sshKey = "/etc/${config.environment.etc."nix/docker_rsa".target}";
    maxJobs = 4;
  }];
}
