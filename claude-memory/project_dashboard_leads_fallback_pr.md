---
name: project_dashboard_leads_fallback_pr
description: Marketing-agent dashboard Meta-pixel-break fallback — migration APPLIED in prod 2026-06-22 (campaign_windowed_totals has the 4 fallback cols); fallback + tracking dots now live
metadata: 
  node_type: memory
  type: project
  originSessionId: 0970f2d8-cad7-47eb-bcd6-f5e88485184b
---

Branch `feat/dashboard-leads-meta-fallback` is pushed to origin (serafimparente-blc/marketing-agent), committed by Charlie, lint-clean, SQL validated read-only against prod. As of 2026-06-22 it is DONE on Charlie's side and waiting on Serafim to finish.

What it fixes: the Green Tide "2026 Heat Pumps - Landing page" campaign showed STALLED on the dashboard but hadn't stalled. The thank-you-page change broke its Meta custom conversion, so the dashboard (which reads ads_insights_daily.conversions per the 2026-06-12 match-Ads-Manager decision) saw 0 leads while it kept spending. Real volume: 29 leads 18-21 Jun, true CPL ~£20.

The change: campaign_windowed_totals falls back to CRM bridge leads for a window ONLY when Meta = 0 but the bridge has leads (keeps Meta-match otherwise). Adds a per-campaign tracking dot (amber = recent pixel break, row running on fallback) so breaks are visible not masked.

Serafim's remaining steps (tier-2 shared-Supabase, his sign-off): review branch -> apply migration `supabase/migrations/20260622000000_campaign_windowed_totals_meta_fallback.sql` in Supabase SQL editor -> merge PR (Vercel deploys). Full apply+verify steps in repo `.claude/docs/current-handoff.md`.

Still open AFTER this lands (the real root cause, not fixed here): re-wire the Green Tide landing page thank-you-page Meta conversion, and the meta-sync NULL/lag-day fix (InstallrHub repo, Serafim). See [[reference_greentide_utm_attribution]] [[feedback_serafim_signoff_and_handoffs]] [[project_greentide]].
