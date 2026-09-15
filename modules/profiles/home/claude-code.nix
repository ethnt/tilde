{ config, pkgs, ... }: {
  programs.claude-code = {
    enable = true;
    package = pkgs.llm-agents.claude-code;
    enableMcpIntegration = true;
    plugins = [ pkgs.i-have-adhd ];
  };

  home.file."${config.programs.claude-code.configDir}/.i-have-adhd-always".text = "";
}
