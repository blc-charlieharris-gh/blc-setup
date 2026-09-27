---
name: reference_manual_meta_sync_single_client
description: How to run a one-client meta-sync backfill from this machine; local SUPABASE_SERVICE_ROLE_KEY in marketing-agent/.env is blank
metadata:
  node_type: memory
  type: reference
  originSessionId: 54db45be-5dae-4d98-bd63-b03bce2e77c4
  modified: 2026-09-26T19:59:15.357Z
---

meta-sync has verify_jwt=false, so a single-client full sync (90-day backfill) runs with the anon key from `marketing-hub/marketing-agent/.env`:
POST `$VITE_SUPABASE_URL/functions/v1/meta-sync?wait=1`, body `{"client_id":"<clients.id>","wait":true}`, apikey/Bearer = anon key. Takes about 1-2 min and returns per-client counts. Used 2026-09-26 for InstallrHub after re-tracking campaigns.

`SUPABASE_SERVICE_ROLE_KEY` in that .env is EMPTY (verified 2026-09-26), so service-role reads of RLS sales tables from a script won't work; use the Supabase MCP (read-only) instead. See [[feedback_supabase_mcp_read_only]].
