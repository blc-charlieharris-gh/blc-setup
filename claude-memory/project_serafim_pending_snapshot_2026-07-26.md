---
name: project_serafim_pending_snapshot_2026-07-26
description: "Snapshot of everything open on Serafim as of 2026-07-26, to revisit after the Targeting-redesign project"
metadata: 
  node_type: memory
  type: project
  originSessionId: 6fb585fc-3733-4aae-bcd3-32a86a3b2f84
---

Parked 2026-07-26 to revisit AFTER the Targeting-section redesign. Source of truth is
`.claude/docs/serafim-pending.md` in marketing-agent (last DB-audited 2026-07-24) — re-read it, this is a pointer not a replacement.

**Urgent, degrading prod:**
1. `GRANT UPDATE ON public.clients TO authenticated;` — one line; without it every client edit (target CPL/CPS, live toggle, meta_ad_account_id) throws "permission denied"; also blocks untracking not-live clients. See [[feedback_rls_needs_table_grant]].
2. InstallrHub `meta_ad_account_id` saved as `7095438517245067` (no `act_`) → meta-sync pulls nothing; fix to `act_7095438517245067` + single-client sync. Blocked behind #1.

**Feature migrations authored, not applied:**
3. `client_reports` (powers the weekly client-reports project — see [[project_client_weekly_reports]]).
4. `creative_hooks` (matcher creative labelling).
5. `creative_ideas` (per-tech ideas board).
6. `ads_insights_breakdown_daily` backfill — table exists, 0 rows; Breakdowns tab empty until ~90d meta-sync backfill runs.
7. Lead-only clients show 0 leads on Tech + Destinations tabs (OPEN 2) — RPCs must take lead count from Meta conversions when `lead_only=true`.

**Bigger build items:**
8. Status-email £50 floor (ship-now, stops false-red pager) + full single-source status engine.
9. `meta-discover-accounts` edge fn (kill hand-typed act_ id at onboarding).
10. `nurture-run` re-deploy (prospect→client exit); no urgency, 0 enrolments.
11. Shared-DB load: enable pg_stat_statements, statement_timeout on heavy reporting RPCs, indexes, cron matviews. See [[feedback_never_starve_shared_prod_db]].

**GT Dashboard repo (deploy there, not migrations here):** test-lead filter parity (app 169 vs hub 165), meta-lead-webhook retry/backoff, intraday Meta spend sync, video-creative thumbnails.

**Recently cleared (don't re-raise):** campaign_creative_cpl re-bound; breakdown TABLE created; crew_seed_audits satisfied (repo CLAUDE.md still lists it as outstanding = stale doc drift). Targeting RPCs client-param work DONE — targeting redesign's data layer is Serafim-clear.
