{
  # programs.ssh = {
  #   enable = true;
  #   extraConfig = ''
  #     IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  #   '';
  # };

  xdg.configFile."../.ssh/config".text = ''
    Host *
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  '';

  xdg.configFile."1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    item = "Personal"
    vault = "Private"
  '';
}
