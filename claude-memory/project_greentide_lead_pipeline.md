---
name: project_greentide_lead_pipeline
description: "Green Tide lead pipeline stages, which tables map to which screens, and how to reconcile without false alarms"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4da3d4aa-0bee-4518-b203-0cad3052d960
---

Green Tide lead flow, in tables (all in the shared InstallrHub Supabase `ozmyjrzleejbqxqphbut`):

`Meta` → `meta_lead_events` → `lead_intake_events` → `leads`

- **`meta_lead_events`** = the **lead intake tab on internal.installrhub** (the screen with the Re-send button). Instant-form leads only; `form_name` like `Greentide%`. `forward_status` of `failed` is visibly flagged/re-sendable; a row that says `forwarded` but is absent downstream is the silent-failure case.
- **`lead_intake_events`** = **raw leads** (admin.installrhub). Every captured enquiry, with full `raw` jsonb. Instant vs landing split lives in `contact_source` (`...Instant Form` vs `...Fillout`). Admin-only RLS.
- **`leads`** = **new leads on the InstallrHub front end** (the booked/published subset, status Available/Claimed/Cancelled). NOT all raw leads. **Do NOT reconcile Meta against `leads`** — it is a smaller booked subset by design, and comparing to it manufactures fake "lost lead" alarms.

**Reconcile Meta → `lead_intake_events`, never Meta → `leads`.**

**Matching gotcha:** there is no shared id between `meta_lead_events`/`lead_intake_events`/`leads`; the only join key is phone/email, and formats differ, so matching is fuzzy.

**CORRECTION (2026-07-09): the re-enquiry dedup is NOT fixed — it silently drops real leads, and the all-time match HIDES that.** Verified: 11 forwarded-but-not-landed Greentide leads in the trailing 14 days, **every one a repeat contact, zero fresh lost**. GHL matches a re-enquiry to the existing contact and never fires the "new lead" intake webhook (row stays `forward_status='forwarded'`, no intake row). A re-enquiry months later is fresh intent and IS a loss. `useLeadReconciliation` decides "reached the DB" by matching phone **all-time** AND only `lead_source='greentide'` — so only leads whose sole prior touch was a *retainer* lead surface (e.g. Julie Johnson: 2 retainer priors, 0 greentide → flagged; the other 10 had a prior greentide intake → hidden). **Fix = match in-window (near the Meta timestamp), all sources**, so re-enquiry misses show unhealthy until an intake row exists. This overturns the old "match all-time to avoid false alarms" rule — that rule buries genuine losses.

Handed to Serafim (`docs/serafim-pending.md` #2): (1) stop GHL swallowing re-enquiries — fire intake on any new leadgen id even for an existing contact; (2) idempotent backfill of the 11 (`docs/backfill-lost-meta-leads-2026-07-09.sql`, keyed on `intake_event_id='meta:'||leadgen_id`, Charlotte chose Option B = all). Detection fix (in-window match) is mine, frontend-only.

Migration context: removing Zapier, hooking Meta → n8n directly. `meta_lead_events` forwarding failed 100% 17-25 Jun then recovered 26-27 Jun (the cutover). Watch the new [[project_dashboard_leads_fallback_pr]]-style reconciliation card (`useLeadReconciliation`, Status page, PR feat/lead-reconciliation-status) as Zapier is fully cut. Landing-page (Fillout) reconciliation still TODO (Meta pixel vs intake, 5% tolerance for browser drop-off). See [[reference_greentide_utm_attribution]], [[dirty_lead_postcodes]].
