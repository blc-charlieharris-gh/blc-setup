---
name: installrhub_cpl_meta_sync_aggregation
description: InstallrHub dashboard CPL reads ~33% low vs Meta because ads_insights_daily.conversions blends multiple result_types
metadata: 
  node_type: memory
  type: project
  originSessionId: 097ece24-1e37-4553-9e99-3718b28ecdfd
  modified: 2026-08-19T14:53:09.785Z
---

Diagnosed 2026-08-19: InstallrHub 14d CPL showed £65.21 on the dashboard vs £97.83 in Meta Ads Manager.

Root cause: CPL formula itself is correct (`spend / leads` in `src/hooks/usePerformanceData.js:51`, spend correctly divided by 100 from `spend_cents`). InstallrHub has `lead_only = true`, so the lead denominator comes from Meta's own synced `conversions` field via the `ad_windowed_totals` RPC / `ad_performance_windowed` (`supabase/migrations/20260810160000_client_attribution_links_split.sql`). That field is summing multiple `result_type`s together ('lead' plus two separate custom-pixel conversions) into one `conversions`/`results` number, inflating the denominator ~40% and deflating CPL.

This is a live violation of [[feedback_meta_lead_counting]] (count via `onsite_conversion.lead_grouped` only). The aggregation happens in `meta-sync`, which lives in a different repo than marketing-agent and, per [[project_edge_fn_repo_drift_A0]], may already be hotfixed live ahead of its repo copy, check the live edge function source, not just the repo, before fixing.

**Why:** lead_only clients (InstallrHub) trust Meta's number directly, so any blending upstream in the sync silently corrupts every lead_only client's reported CPL, not just InstallrHub's.
**How to apply:** before trusting or fixing dashboard CPL for any lead_only client, check whether ads_insights_daily.conversions for that client's ads is summing multiple result_types. Pull the live meta-sync function via Supabase MCP first.
