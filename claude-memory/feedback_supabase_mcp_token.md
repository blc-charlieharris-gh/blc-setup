---
name: feedback_supabase_mcp_token
description: "Supabase MCP gotchas — never hand the user a `claude mcp add` command with a placeholder token; it is read-only; recover a clobbered token from ~/.claude.json backups"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 5b6e74e3-fb6d-4e49-ae0d-cb53211a7258
---

The Supabase MCP for the BLC project is configured in `~/.claude.json` under `projects["/Users/charlotteharris/Documents/BLC"].mcpServers.supabase`, with the token in **`env.SUPABASE_ACCESS_TOKEN`** (NOT in args), `--read-only --project-ref=ozmyjrzleejbqxqphbut`.

**What went wrong (2026-06-29):** I gave Charlotte a fix-it command `claude mcp add supabase -- ... --access-token=sbp_xxx` with a literal placeholder. She ran it verbatim, which **overwrote the real token with the string `sbp_xxx`** (Supabase then returned "Unauthorized"). Recovered the real token from `~/.claude.json.backup` (Claude Code also keeps timestamped backups in `~/.claude/backups/.claude.json.backup.<ts>`) and restored the whole server object.

**How to apply:**
- NEVER give the user a runnable `claude mcp add ... --access-token=<literal>` command. If a token must be set, leave a clearly-non-runnable placeholder they replace, or have them paste the token and edit `~/.claude.json` yourself.
- MCP servers are **scoped per launch directory**. Launching Claude from the BLC root vs `marketing-hub/marketing-agent` changes which servers load ("worked yesterday, gone today" = different cwd). Copy the server object into the needed project key if so.
- The token is **`--read-only`**, so INSERT/UPDATE fail ("cannot execute INSERT in a read-only transaction"). Shared-prod writes (e.g. new `clients` rows) go to Serafim, not via MCP. See [[reference_git_auth]] and [[feedback_serafim_signoff_and_handoffs]].
