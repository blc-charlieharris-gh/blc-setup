---
name: reference_reporting_rpcs_are_hub_only
description: ad_windowed_totals / ad_performance_windowed and sibling reporting RPCs are called only by the Hub, verified via API logs 2026-09-23
metadata:
  type: reference
---

Verified 2026-09-23: every call in 24h of edge_logs to `ad_windowed_totals`, `campaign_creative_cpl`, `campaign_windowed_totals` and `reconcile_leads` (1,145 calls) had referer `internal.installrhub.com` (the Hub); none from `app.installrhub.com`; no pg_cron job calls them. So changes to `ad_performance_windowed` and these RPCs are Hub-only and don't need Serafim's review, per [[feedback_hub_only_migrations_no_serafim_review]].

**Why:** a Hub code comment (useDesignPerfCreatives.js) says app.installrhub "also hits" ad_windowed_totals; that led to a wrong Tier-2 call. It's about shared DB load, not a dependency.

**How to apply:** before calling a migration cross-repo, check edge_logs referer for the RPC path via query_logs (`log_attributes['request.path']` / `['request.headers.referer']`) instead of trusting comments. Re-verify if Serafim's app changes.
