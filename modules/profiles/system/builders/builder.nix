{
  imports = [ ./common.nix ];

  nix = {
    buildMachines = [{
      hostName = "builder";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 8;
      speedFactor = 1;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
      sshUser = "builder";
      sshKey = "/Users/ethan/Workspace/e10/keys/builder_rsa";
    }];

    settings = { builders-use-substitutes = true; };
  };
}
