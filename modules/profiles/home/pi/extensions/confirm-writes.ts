import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Ask for confirmation before using a tool that writes to a file. Toggle
// auto-approval mode with `/auto-approve`

const GATED_TOOLS = new Set(["write", "edit"]);

export default function (pi: ExtensionAPI) {
  let autoApprove = false;

  pi.registerCommand("auto-approve", {
    description:
      "Toggle auto-approve of file writes/edits for this session (on/off)",
    handler: async (arg, ctx) => {
      const normalized = arg.trim().toLowerCase();
      if (normalized === "on") autoApprove = true;
      else if (normalized === "off") autoApprove = false;
      else autoApprove = !autoApprove;

      ctx.ui.notify(
        autoApprove
          ? "Auto-approve ON: file writes/edits run without a prompt."
          : "Auto-approve OFF: file writes/edits require confirmation.",
        autoApprove ? "warning" : "info",
      );
    },
  });

  pi.on("tool_call", async (event, ctx) => {
    if (!GATED_TOOLS.has(event.toolName)) return;
    if (autoApprove) return;

    const path =
      typeof (event.input as { path?: unknown }).path === "string"
        ? (event.input as { path: string }).path
        : "(unknown file)";

    const action =
      event.toolName === "write" ? "Write/overwrite file" : "Edit file";
    const approved = await ctx.ui.confirm(action, path);
    if (!approved) {
      return {
        block: true,
        reason: `${event.toolName} on ${path} was not approved by the user`,
      };
    }
  });
}
