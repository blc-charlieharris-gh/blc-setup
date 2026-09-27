---
name: project-higgsfield
description: "Higgsfield visual generation wired into the meta-access project via official CLI, BLC Promotions team workspace"
metadata: 
  node_type: memory
  type: project
  originSessionId: d2444d13-fd9a-4d8b-b164-cf945900dc7f
---

The `meta-access` BLC project can generate images/video via the official **Higgsfield CLI** (`higgsfield`, aliases `higgs`; note `hf` is only an internal subcommand alias, NOT a binary). Installed globally via npm at `/opt/homebrew/bin/higgsfield`.

- Auth: browser OAuth (`higgsfield auth login`), no API key. Signed in as charlieharris@blc-promotions.com. Creds in `~/.config/higgsfield/credentials.json`.
- Workspace: set to **BLC Promotions** (team plan, ~66 credits) via `higgsfield workspace set 07bf0227-6667-47e7-9e89-a4ddcce65d48`. Private account has 0 credits, so always confirm workspace status shows BLC Promotions before generating.
- Usage: `higgsfield generate cost <model> --prompt "..."` to estimate, then `generate create`. Also has `marketing-studio`, `product-photoshoot`, `soul-id` subcommands. `model list` for catalog.
- Higgsfield's own docs say CLI is preferred over MCP for Claude Code (cheaper, no context tooling cost). Remote MCP at https://mcp.higgsfield.ai/mcp is for the claude.ai web app.

**Why:** Generations cost credits and bill to whichever workspace is selected; getting the wrong one (Private/0) makes everything fail.
**How to apply:** Before any Higgsfield generation, run `higgsfield workspace status`; if not BLC Promotions, re-set it. Estimate cost before spending. Related: [[project_greentide]], [[project_installrhub]].
