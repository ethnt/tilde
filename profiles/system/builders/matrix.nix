{
  nix.buildMachines = [{
    hostName = "192.168.1.202";
    systems = [ "x86_64-linux" "aarch64-linux" ];
    sshUser = "root";
    sshKey = "/Users/ethan/Workspace/e10/keys/id_rsa";
    maxJobs = 4;
  }];
}
