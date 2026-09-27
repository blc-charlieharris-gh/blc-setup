---
name: project_serafim_outstanding_2026_07_29
description: "Serafim's outstanding Tier-2 queue, DB-verified 2026-08-10; nothing moved since 08-07 16:05, SWH still archived, checklist still never UPDATEs, 0c-bis migration still unapplied"
metadata:
  node_type: memory
  type: project
  originSessionId: e306d040-3199-4d38-bd90-f2686f851312
  modified: 2026-08-10T12:23:55.005Z
---

Serafim owns all Tier-2 (shared-Supabase migrations + edge-fn deploys). Canonical list =
`marketing-agent/.claude/docs/serafim-pending.md`, refreshed and DB-verified 2026-08-07.

**LANDED 2026-08-07:** `short_links` migration applied at last (`20260807102723`), so the
/sources Links tab stops erroring. `is_retainer` set true on Gas Worx + LJP
(`20260807102900`). Test rows deleted (`20260807103105`). Earlier: `ghl-installr-lead-webhook`
v11, `meta-sync` v43, `marketing-status-check` v20 all mirrored, so the A0 drift is CLOSED.

**Onboarding DOES complete now** (it never had before): 2 of 11 tokens consumed, SWH 08-07
07:18 and placementtestingignore 08-07 12:35. Item 0 is therefore CLOSED.

**2026-08-10 PM:** he is ACTIVE again, but on new work, not this list. Shipped a **partner lead
delivery** feature today: migrations `20260810104853 partner_lead_deliveries` +
`20260810120543 scheduled_sms_partner_lead_workflow`, new edge fn `partner-lead-delivery` v3,
plus `ghl-sync` v107, `installer-whatsapp` v96, `send-installer-email` v26. Table tracks per
channel (`email_sent_at`/`email_error`, `wa_sent_at`/`wa_error`) with a `dedup_key`, gated by
`companies.partner_lead_delivery_enabled`. **It has NEVER RUN: 0 rows, and the only company with
the flag on is Mark Harvey Renewables, which is `is_active = false`.** No commits to
marketing-agent since #524 (08-06), so this is all InstallrHub-side.

**RE-VERIFIED 2026-08-10 (morning), still true at PM check:** none of the items below have moved. His last DB migration is `20260807155453`
(retainer_blackouts) and his last edge-fn deploy `installer-leads-view` v45, both 08-07 ~16:00.
No activity 08-08/09 (weekend) or 08-10 so far. Every item below still reads the same in the DB:
SWH (`a00a6d98`, now named "Sean") still `is_active=false` + `archived_at 08-06 12:48`;
Arktek Office (`1c5a786e`) still `is_active=false`; placementtestingignore (`a5e0e372`) checklist
still `{}`. New since: his PR **#532** is OPEN and corrects §0c-bis, writing `'test'` to
`meta_lead_events.source` violates a CHECK constraint so the row is LOST not marked. Fix needs
migration `20260807120000` (written in InstallrHub PR #286) applied BEFORE any
`deploy-edge.sh ghl-installr-lead-webhook`; that migration is NOT in the applied list yet. Also,
live webhook is **v13** (deployed 08-04), not v11 as this file previously said.

**STILL OPEN (2026-08-07):**
- **SWH Electrical still archived** (`a00a6d98-...`): `archived_at` 08-06 12:48, `is_active`
  false. His backfill touched the row and left both, so Charlotte still cannot link them on
  Manage Clients. Top of the list.
- **Arktek `is_active` flipped false** at 08-07 12:22, unexplained. Live client.
- **Checklist can never be UPDATE'd after its row exists.** `writeCommercialSatellites` only
  inserts. REPRODUCED TWICE: both completions above left their checklist untouched
  (placementtestingignore's is `{}`). See [[feedback_onboarding_form_dead_controls]].
- `is_retainer` misnamed, see [[reference_is_retainer_means_buys_calling]].
- Completing onboarding does not clear `archived_at`.
- `leadDelivery` + `onboardingCall` have no column; both folded into `onboarding_answers` as
  text as a stopgap.
- Phase 4: `addInstaller()` browser INSERT with no duplicate check, 3 call sites.

**DECIDED AGAINST, do not re-raise:** a GHL webhook for onboarding-call bookings. The calendar
is a cross-origin iframe so we cannot know; booking is required and gated on the client's own
tick, and a no-show surfaces as a missing appointment.

**Verify read-only (`SET statement_timeout='8s'`):** `archived_at`/`is_active` on the SWH id;
`consumed_at` count on `onboarding_invite_tokens`; `checklist` on `client_onboarding` for a
consumed company; `to_regclass('public.short_links')`.
