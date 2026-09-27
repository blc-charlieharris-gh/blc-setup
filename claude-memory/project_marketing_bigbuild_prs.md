---
name: project_marketing_bigbuild_prs
description: "Marketing-agent big build (2026-06-23) — 3 PRs pushed awaiting Charlotte's preview+merge, plus a consolidated Serafim DB batch"
metadata: 
  node_type: memory
  type: project
  originSessionId: dcd425df-606d-4279-b94c-f445e79a793d
---

✅ CLOSED 2026-06-24: Serafim applied + verified the ENTIRE consolidated DB batch (his handoff #84). Live now: `creative_merges`/`creative_reviewed` (By-creative merges persist cross-device), `tech_windowed_totals` (Tech tab fills), `targeting_postcode_flow`(+weekly) (Lead-flow panel fills). All big-build frontend PRs merged (#79 drawer, #80 tech, #81 geo). My targeting tech-classification fix merged #82. Serafim's #83 synced the missing SECDEF migrations to main (tree now matches live DB) + closed #71. Both caveats RESOLVED: couldn't-place def confirmed (177=177 vs destination_funnel), ghlContactId bridge canonical, tech optimization_goal join matches destination_funnel. He added migration `20260624000000_postcode_flow_date_cast` (geo postcode-flow now uses `occurred_at::date` basis; was dropping the final day's cohort). NOTE: `targeting_postcode_flow` returns raw junk/PII free-text postcode (absorbed by FE town rollup + <5 floor) — ties to [[project_dirty_lead_postcodes]]; a stray `New skills/` folder must NEVER be committed to this repo. Nothing outstanding on Serafim for this batch. Below = historical detail.

STATUS 2026-06-23 PM: Creatives base fold MERGED to main (#76/#77). PR #78 was a duplicate of the creatives branch polluted with workdir-corruption " 2" files + conflicts — CLOSED (branch deleted). Rich drawer rebuilt clean on **feat/creative-rich-drawer**. THREE clean PRs await Charlotte's merge (all verified 0-conflict vs main): feat/creative-rich-drawer, feat/tech-subtab, feat/geo-lead-flow. Plan in `.claude/docs/current-plan.md`; Serafim batch in `.claude/docs/current-handoff.md` (rides in with the geo PR). LESSON: never `git add -A` in this repo (the recurring `* 2` corruption gets committed); stage explicit paths.

- **feat/creative-rich-drawer** (B, the part not yet merged): clicking a creative opens the full ad-drill-down depth (lifetime/trailing windows/daily chart/funnel/lost reasons/recent leads) aggregated across the creative's ads via useCreativeDrilldownData, + editable purpose/notes. Reuses exported Funnel/DailyChart/WindowedMetrics/Stat from AdDrilldown. Frontend-only. (The light fold + tab retire is already live.)
- **feat/tech-subtab** (A): Performance "Tech" tab, HP vs Solar on CPL/cost-per-booked/CPCS + lost COUNT (window lost-rate is misleading, like per-ad Loss%), split by destination. Needs RPC `tech_windowed_totals` (migration in branch).
- **feat/geo-lead-flow** (C): "Lead flow by town" panel under the Targeting map. COHORT-based (rates key to lead arrival, not windowed counts), town-first (postcodes ~unique, 908/910), rates hidden <5 leads, explicit unmapped-leads banner, weekly sparkline, maturation caveat. Needs RPCs `targeting_postcode_flow` + `_weekly` (DRAFT — Serafim must confirm the "couldn't place" definition + lead->slot ghlContactId linkage). Map rate-choropleth deferred (point layers already show geography).

**VERIFIED DB STATUS 2026-06-24 (queried live):** The 2026-06-18 handoff RPCs are APPLIED (`reconcile_leads`, `destination_funnel`, `targeting_claims_by_installer` all exist live). The consolidated batch below is NOT yet applied: `creative_merges`/`creative_reviewed` tables absent, `tech_windowed_totals` absent, `targeting_postcode_flow`(+weekly) absent. So creative merges still localStorage-only; Tech tab + Lead-flow panel still show pending notes. Still waiting on Serafim for items 1-3 below. (Open caveats also unverifiable from DB: destination_funnel classifier-sync confirmation, and the couldn't-place definition.)

**Consolidated Serafim batch (one pass, he does all DB):**
1. Apply `20260623000000_creative_merges_persistence.sql` (already on main, #74) → creative merges stop resetting.
2. Apply `20260623000100_tech_windowed_totals.sql` (in feat/tech-subtab) → Tech tab lights up.
3. Apply `20260623000200_targeting_postcode_flow.sql` (in feat/geo-lead-flow) AND confirm the couldn't-place definition + cohort linkage → Lead flow lights up.
4. Merge his `db/secdef-destination-targeting-rpcs` branch (already-applied migrations+docs) and close PR #71 (superseded by #73, live).

Frontends ship behind "available" guards so A/C show a pending note until their RPC lands. See [[feedback_serafim_signoff_and_handoffs]] (Charlotte never runs SQL). Today already live: #72 (alerts+blended+tech badges), #73 (tracking-break dot + NO LEADS), #74 (creative persistence FE), plus the tracking-dot fix.
