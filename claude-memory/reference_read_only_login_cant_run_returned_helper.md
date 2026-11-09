---
name: reference-read-only-login-cant-run-returned-helper
description: supabase_read_only_user has no execute on hub_survey_returned, so ad_windowed_totals, survey_reconciliation, list_bookings_for_ad error when Claude calls them directly
metadata:
  type: reference
---

Since 2026-11-09 the booked-numbers functions call `hub_survey_returned` (SECURITY DEFINER, granted to anon, authenticated, service_role only). The read-only MCP login (`supabase_read_only_user`) gets "permission denied for function hub_survey_returned" if it runs the helper or a function that reaches it. The app's logins are fine. To check a return, read `hub_survey_returns` directly (the read-only login can) and compare `resolved_at >= booked_at`.

Related: [[feedback-supabase-mcp-read-only]]
