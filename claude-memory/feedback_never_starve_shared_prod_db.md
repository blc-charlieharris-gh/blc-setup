---
name: feedback-never-starve-shared-prod-db
description: NEVER run heavy reporting RPCs against shared prod via Supabase MCP; it starves app.installrhub and stops the telesales team working. Always SET statement_timeout first.
metadata: 
  node_type: memory
  type: feedback
  originSessionId: b5c8df83-125c-476e-a5e1-e2aaf870fa2d
---

Charlotte, 2026-07-17, after I caused it: **we must never cause a shared-prod DB timeout. It impacts the telesales team using app.installrhub.**

**What I did:** ran `SELECT * FROM tech_windowed_totals(current_date-30, current_date-1, '<uuid>')` once via `mcp__supabase__execute_sql`, as a one-off priming check. It ran for **76 seconds** and starved the InstallrHub admin app's leads boot query past its 8s `statement_timeout`, producing bursts of `57014 canceling statement due to statement timeout` (2026-07-17, ~11:33-11:44 UTC). Every open telesales tab retried. Serafim traced it back from the Postgres slow-query log to the PAT.

**Why it hurt so much:** the browser calls these RPCs as the `authenticated` role, which has an **8s statement_timeout**, so a user just gets a fast error. The **Supabase MCP / PAT path has no such cap**, so the same query runs unbounded and hogs shared prod. The dangerous thing is the *path I use*, not the query being unusual.

**Root cause of the slowness:** `ad_performance_with_leads` is an **unbounded view**. The RPC's date window is applied outside it, but the view first builds 7 aggregate CTEs over full table history (worst: `calls_by_ad_day` joins all ~42.8k `calls` to ~10.8k `lead_intake_events` on `ghl_contact_id` with **no date bound**, plus 5 correlated LATERAL subqueries). Asking for 30 days costs the same as asking for all time.

**How to apply:**
- **Never** call the reporting RPCs via MCP against prod: `tech_windowed_totals`, `destination_funnel`, `ad_windowed_totals`, `campaign_creative_cpl`, or any raw select over `ad_performance_with_leads`.
- If a reporting number is genuinely needed, **self-cap first in the same call**: `SET statement_timeout = '5s'; SELECT ...`. A failed query is always better than a starved app.
- Prefer cheap paths: catalog reads (`pg_get_functiondef`, `pg_get_viewdef`, `information_schema`, `pg_stat_user_tables`), targeted queries on base tables with a date filter, or `EXPLAIN` **without** `ANALYZE` (it does not execute).
- To answer "did the backend change land?", read the **function body / migration**, don't execute the function.
- Proposed permanent de-fang (Tier-2, with Serafim): `ALTER FUNCTION public.tech_windowed_totals(date,date,text) SET statement_timeout = '10s';` (same for `destination_funnel`), then bound the view's CTEs by date or materialise a daily rollup refreshed by meta-sync.

This DB is shared: marketing hub + InstallrHub app + public blog. A slow query here is not a private cost, it stops people working. See [[feedback_supabase_mcp_token]] (the MCP token is read-only, which prevents writes but does **not** prevent this).
