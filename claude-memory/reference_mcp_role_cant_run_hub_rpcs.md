---
name: reference_mcp_role_cant_run_hub_rpcs
description: Claude's read-only Supabase MCP role gets "permission denied" on hub_as_codes_overview, adset_codes and ad_windowed_totals/ad_performance_windowed (10-19)
metadata:
  type: reference
---
The Supabase MCP (read-only) cannot execute the Hub's staff RPCs: hub_as_codes_overview, adset_codes, ad_windowed_totals
(it calls ad_performance_windowed). So per-ad / per-ad-set report numbers can't be checked by SQL from Claude; build
on the RPCs the Hub already uses in the browser and ask Charlotte to compare one row with Ads Manager. Raw tables
(direct_booking_adset_links, ads_adsets, campaign_checkins, client_onboarding) read fine. Related: [[reference_blc_supabase_cli_wrapper]]
