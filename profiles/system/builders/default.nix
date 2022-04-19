{
  nix.distributedBuilds = true;

  nix.buildMachines = [{
    hostName = "nix-docker";
    systems = [ "x86_64-linux" ];
    sshKey = "/etc/nix/docker_rsa";
    maxJobs = 2;
  }];
}
