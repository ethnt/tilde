{
  imports = [ ./common.nix ];

  nix = {
    buildMachines = [{
      hostName = "eu.nixbuild.net";
      system = "x86_64-linux";
      maxJobs = 100;
      supportedFeatures = [ "benchmark" "big-parallel" ];
      sshKey = "/Users/ethan/Workspace/e10/keys/nixbuild";
    }];

    settings = { builders-use-substitutes = true; };
  };
}
