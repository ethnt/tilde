{
  imports = [ ./common.nix ];

  nix = {
    buildMachines = [
      {
        hostName = "fabricator";
        protocol = "ssh-ng";
        systems = [ "x86_64-linux" ];
        maxJobs = 32;
        speedFactor = 1;
        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "big-parallel"
          "kvm"
        ];
        mandatoryFeatures = [ ];
        sshUser = "builder";
        sshKey = "/Users/ethan/Workspace/e10/keys/builder_rsa";
      }
    ];

    settings = {
      builders-use-substitutes = true;
    };
  };
}
