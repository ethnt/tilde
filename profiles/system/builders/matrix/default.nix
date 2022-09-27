{
  nix.buildMachines = [{
    hostName = "builder.orchard.computer";
    systems = [ "x86_64-linux" "aarch64-linux" ];
    sshKey = toString ./builder;
    maxJobs = 4;
    sshUser = "builder";
    supportedFeatures = [ "big-parallel" "kvm" ];
  }];
}
