{ config, lib, pkgs, ... }:
let memoryDir = "${config.xdg.dataHome}/mcp-memory";
in {
  programs.mcp.servers.memory = {
    command = lib.getExe pkgs.mcp-server-memory;
    args = [ ];
    env = { MEMORY_FILE_PATH = "${memoryDir}/memory.jsonl"; };
  };

  home.activation.createMcpMemoryDir =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p "${memoryDir}"
    '';
}
