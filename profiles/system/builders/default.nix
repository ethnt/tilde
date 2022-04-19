{
  nix.distributedBuilds = true;

  nix.buildMachines = [{
    hostName = "nix-docker";
    systems = [ "x86_64-linux" ];
    sshKey = "/etc/nix/docker_rsa";
    maxJobs = 2;
  }];

  # environment.etc = {
  #   "nix/remote-build-env" = {
  #     enable = true;
  #     text = ''
  #       #!/usr/bin/env bash
  #       mkdir -p /tmp/nix/current-load
  #       chmod a+rwX /tmp/nix/current-load
  #       export NIX_BUILD_HOOK="${HOME}/.nix-profile/libexec/nix/build-remote.pl"
  #       export NIX_REMOTE_SYSTEMS="/etc/nix/remote-systems.conf"
  #       export NIX_CURRENT_LOAD="/tmp/nix/current-load"
  #     '';
  #   };
  # };
}
