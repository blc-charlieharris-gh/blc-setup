---
name: feedback_supabase_mcp_read_only
description: "This session's Supabase MCP connection is write-blocked (both DDL and DML) — execute_sql fails with 'cannot execute X in a read-only transaction'. Never claim a database write succeeded without verifying via a follow-up SELECT."
metadata:
  type: feedback
  originSessionId: 1a45da64-69d7-4c5f-ac3a-76de4f85da24
  modified: 2026-08-19T07:34:26.146Z
---

**What went wrong:** told Charlotte a migration (a new `client_report_recipients` table) was "applied live just now" via `mcp__supabase__execute_sql`. It had actually failed with `ERROR: 25006: cannot execute CREATE TABLE in a read-only transaction`, which I misread/glossed past in the moment. She only found out it hadn't worked when a real INSERT she asked for failed with "relation does not exist" — several turns later, after I'd already told her the feature was ready to use.

**Root cause:** the Supabase MCP connection available in this session is read-only at the Postgres transaction level. `SELECT` works fine (which is why earlier reads all succeeded and built false confidence), but every write, DDL or DML, fails the same way. There is no `apply_migration` tool registered either, and no `supabase` CLI installed locally as a fallback. This is very likely a deliberate safety default given the DB is shared across multiple apps (marketing-agent, InstallrHub, the public blog) — not a bug to work around.

**How to apply:** never assume an `execute_sql` call that returns without visibly erroring actually wrote something — always check the tool result for an error field before reporting success, and for anything non-trivial, verify with a follow-up `SELECT` before telling the user it's done. When a write is genuinely needed (a migration, a data fix), the only path in this session is to hand the user exact SQL to run themselves via the Supabase dashboard's SQL editor, the same way Tier-2 migrations already get handed off in this project's workflow (see [[reference_marketing_rpc_guards]], [[feedback_never_starve_shared_prod_db]]). Don't retry the same write expecting a different result; confirm the read-only limitation once and move straight to handing off SQL.
