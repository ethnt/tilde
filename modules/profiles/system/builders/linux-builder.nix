{
  nix.linux-builder = {
    enable = true;

    # NOTE: If building this configuration from scratch (i.e., brand new system), comment out this configuration
    # first, otherwise we can't build the builder itself
    config = {
      services.qemuGuest.enable = true;
    };
  };
}
