---
name: project_new_client_onboarding_reality
description: "What actually breaks when adding a new ad client (learned onboarding InstallrHub 2026-07-28) - the act_ prefix trap, missing UPDATE grant blocking edits, no in-app sync trigger, full-sync rate-limit fragility, daily-scorecard-first then 14D lag. Read before touching the onboarding flow."
metadata: 
  node_type: memory
  type: project
  originSessionId: 726b17e5-24fc-4a96-96ab-28ba57a9c410
---

Onboarding InstallrHub on 2026-07-28 exposed the real friction in adding a new ad client via `/clients`. The next client hits all of this again until the flow is fixed. Related: [[project_clients_onboarding_home]], [[project_installrhub_meta_tracking]].

**The `act_` prefix trap.** `/clients` lets you paste a raw Meta ad-account id. If you paste `7095438517245067` without the `act_` prefix, meta-sync can't resolve the account and pulls NOTHING, silently. No validation, no error. Fix must enforce/auto-add `act_`, or go discovery-first (the `meta-discover-accounts` edge fn, still unbuilt) so no id is pasted by hand.

**You can ADD a client but not EDIT one.** `authenticated` has SELECT/INSERT/DELETE but NOT UPDATE on `public.clients` (see [[feedback_rls_needs_table_grant]]). So INSERT (add) works, but any Save on an existing client throws "permission denied for table clients". That means a fat-fingered `act_` id (or target CPL, tracking toggle, company link) CANNOT be corrected in-app. STILL OPEN on Serafim: `GRANT UPDATE ON public.clients TO authenticated;`.

**Nothing syncs on add.** There is NO in-app "sync now" button (only a last-synced status readout in TopBanner). A new client's data does not appear until a `meta-sync` run covers it: the 3am nightly (`{}` full) or the hourly `:15` today-only (`{"today_only": true}`). meta-sync is invoked by POST to `https://ozmyjrzleejbqxqphbut.supabase.co/functions/v1/meta-sync` with the publishable apikey (that's all the cron does). See [[reference_never_starve_shared_prod_db]] before triggering anything heavy.

**The full sync can die mid-way on a new/large client.** meta-sync processes clients SEQUENTIALLY and writes a `sync_runs` row per client (status/records_synced/error_message). InstallrHub was last in the queue; during Greentide's big pull Meta returned "Application request limit reached" (app rate cap), and InstallrHub's run stalled at "started" and never finished, leaving 15 campaigns + 398 ads but 0 insights (spend). A lighter `today_only` re-run ~25 min later succeeded (rec=4). So a new client can end up with structure but no spend. The robust onboarding path is a TARGETED single-client sync (fresh rate budget), same as Arktek.

**Daily scorecard first, 14D views lag.** A freshly-synced client only has today's data, so it shows on the daily scorecard immediately but NOT on the Tracked-campaigns 14D list until history backfills (nightly). Not a bug; set the expectation.

**Other per-client onboarding switches:** `lead_only` (drops bookings metrics; does NOT block sync, other lead_only clients sync fine), per-campaign `is_tracked` toggles, `clients.company_id` link for retainer coverage on Targeting (column exists but needs the grant to populate; names don't match so it's a manual link), and the lead pipeline (Meta forms via `meta-lead-webhook`, or landing forms via n8n; configure routes in Lead Intake > Forms, whose Active tick is routing not visibility, see [[reference_leadintake_forms_active_tick]]).
