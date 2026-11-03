---
name: reference_supabase_mcp_and_meta_token_on_mac
description: Which Supabase MCP server and Meta token work for read-only checks on this Mac
metadata:
  type: reference
---

On this Mac (3 Nov 2026):
- The `supabase` MCP server gets "permission denied" on Hub functions (`hub_as_codes_overview`, `adset_codes`) and disconnects mid-session; the `f958b3d7-…` Supabase MCP (`execute_sql` with project_id `ozmyjrzleejbqxqphbut`) reads them, plus `query_logs` and `list_edge_functions` (client-portal version check).
- Live Meta reads: the token in `~/code/BLC/meta-access/.env` works; `META_ACCESS_TOKEN` in marketing-agent `.env.local` answers "(#200) Provide valid app ID".

Related: [[reference_blc_supabase_cli_wrapper]], [[feedback_migration_version_collision_between_sessions]]
