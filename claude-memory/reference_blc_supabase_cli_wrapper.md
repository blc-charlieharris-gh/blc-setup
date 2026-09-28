---
name: reference_blc_supabase_cli_wrapper
description: Claude has NO Supabase write access - Charlotte deploys edge fns (single-file paste from ~/Code/BLC/_deploy) and runs SQL herself; blc-supabase wrapper is read-only use
metadata:
  type: reference
---

Plain `supabase` CLI on the laptop (Charlotte's MacBook Air, where her other projects live) is logged into Charlotte's personal account (only "charlotte@switchleads.co.uk's Project" listed); the BLC/InstallrHub project `ozmyjrzleejbqxqphbut` isn't reachable with it. Supabase MCP is read-only.

`~/code/blc-setup/bin/blc-supabase` (added 2026-09-28): `set-token` stores a BLC access token in keychain service `blc-supabase` (account `blc`); every call exports it as SUPABASE_ACCESS_TOKEN for that command only, so the global login is untouched. `blc-supabase deploy <fn>...` deploys from ~/code/BLC/marketing-hub/marketing-agent with `--use-api`, `--no-verify-jwt` only for a named list (marketing-status-check, hub-action-alerts, meta-sync, marketing-sweep, creative-gen, google-sync, broadcasts, marketplace-campaign); others keep the JWT check. `--use-api` drops static_files (see [[feedback_edge_fn_static_files_needs_docker]]). Related: [[reference_device_switching_blc_setup]].


2026-09-28: the "laptop Claude" token (also the BLC Supabase MCP token in ~/.claude.json projects[/Users/personal/Code/BLC]) is a SCOPED read-only token: deploy fails 403 "Missing required permission(s): edge_functions_write". It sees only the InstallrHub project. For deploys Charlotte makes a token scoped to InstallrHub with Edge Functions write, then `blc-supabase set-token` (the keychain entry holds the read-only one until then).

**Charlotte 2026-09-28: Claude does NOT get write access to Supabase.** She deploys edge fns and runs SQL herself. For an edge fn change I build a single-file copy (inline `_shared/*` imports, rename clashing imports, `// @ts-nocheck` header, parse-check with deno) into `~/Code/BLC/_deploy/<fn>.ts`, and give dashboard steps (Edge Functions > fn > Code > paste > keep "Verify JWT" as it is > Deploy). Migrations: SQL file in a PR + she runs it in the SQL editor. blc-supabase stays for read-only CLI use.

2026-09-28: my first hand-bundled status-check copy failed to BOOT in prod (duplicate `SUPABASE_URL` from inlined error-log.ts; `deno check` with @ts-nocheck didn't catch it) and the 21:00 run was lost. Always use `scripts/bundle-edge-fn.py <fn>` then `scripts/boot-check.sh <file>` (must print "Listening") before handing a paste file over, and check function_logs for "boot error" after she deploys.
