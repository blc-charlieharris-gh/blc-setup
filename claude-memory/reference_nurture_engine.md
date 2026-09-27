---
name: reference_nurture_engine
description: "How the InstallrHub prospect nurture engine works (enrolment, stop-on-stage exit, step timing, unsubscribe). UI at /emails Nurture tab; engine = nurture-run/nurture-enroll edge fns."
metadata: 
  node_type: memory
  type: reference
  originSessionId: 726b17e5-24fc-4a96-96ab-28ba57a9c410
  modified: 2026-09-03T14:43:12.604Z
---

**UPDATE 2026-09-03 (deployed live, verified via version bump 19→20 on both fns):** `nurture_steps.delay_hours` is gone from the app's vocabulary, replaced by `delay_minutes` (hour+minute precision; the DB column `delay_hours` itself was deliberately KEPT as an inert legacy column rather than dropped in the same migration, to avoid breaking the then-still-old edge fns mid-rollout — safe to actually drop it now that both fns are redeployed). Added `nurture_steps.delay_type` (`after_enrollment`, unchanged v1 cumulative-from-`enrolled_at` behaviour; or `before_date`, counting back from a new `nurture_sequences.target_date` — one shared date/time per sequence, e.g. a webinar, same instant for every enrollee regardless of when they joined). Added `nurture_steps.channel` (`email`/`sms`) + `sms_body` — a sequence can now mix email and SMS steps in one ordered flow; SMS sends via GHL's Conversations API (`POST /conversations/messages`, `type: SMS`) using the enrolment's existing `ghl_contact_id` (GHL resolves the phone, we never store one), needs `GHL_API_TOKEN`/`GHL_LOCATION_ID` set as edge-fn secrets. `before_date` steps auto-skip (not late-send) once their computed time is >60 min stale, and are rate-limited to `DATE_LOCKED_BATCH_PER_TICK=20` sends per 20-min tick since they're all due at the same instant for a whole queue at once. Full detail/PR: marketing-agent PR #741 + `fix/defer-delay-hours-drop`, doc `docs/nurture-sms-and-date-anchored-steps-2026-09-03.md`.

**Deploy-path correction:** despite `marketing-agent/CLAUDE.md` documenting edge fns as deploying from a separate "Green Tide Dashboard" repo (not cloned locally, see [[reference_installrhub_dashboard_repo_not_local]] for the DIFFERENT-but-easily-conflated app.installrhub.com frontend repo), `nurture-run`/`nurture-enroll` were successfully redeployed by pasting the new source straight into the Supabase dashboard's Edge Function editor + clicking Deploy — no repo checkout needed. See [[feedback_supabase_dashboard_deploy_silent_noop]] for the "must verify the version actually bumped" gotcha that applies to this same path.

OPEN/CLICK TRACKING (07-29): nurture_sends.opened_at/clicked_at are stamped by the `nurture-resend-webhook` edge fn (deployed, code correct: Svix-verify -> match resend_message_id -> stamp). Needs BOTH (a) a Resend webhook endpoint pointing at `.../functions/v1/nurture-resend-webhook` subscribed to email.opened/clicked/bounced/complained, AND (b) `RESEND_WEBHOOK_SECRET` on Supabase edge fns matching that endpoint's whsec_. If either is missing, ALL opened_at/clicked_at stay null (silent 401, no error_log row). 07-29 root cause: the endpoint never existed. Charlotte created it; Serafim to set the secret. See [[feedback_lead_only_blanks_cpbl]].

Verified against the DEPLOYED functions 2026-07-28.

**Model:** `nurture_sequences` (trigger_type `funnel` or `stage`, `stop_on_stages[]`, `funnel_key`, `active`) + ordered `nurture_steps` (`delay_hours`, `subject`, `body_html`). UI: `src/pages/hub/Emails.jsx` Nurture tab, `src/components/emails/nurture/*`, `src/lib/nurtureApi.js`. Admin-only RLS.

**Enrolment (two paths, no collision):**
- `funnel` sequences: PUSH via the `nurture-enroll` webhook, keyed by `funnel_key`. A GHL/n8n funnel workflow POSTs `{funnel_key,email,first_name,company,ghl_contact_id}` + `X-Nurture-Secret`. No funnel_key on the sequence = nothing enrols, even if active + has steps.
- `stage` sequences: PULL via `nurture-run` reconcile, auto-enrols every `installer_prospects.stage == trigger_stage`. No GHL needed.

**Exit:** funnel sequences exit an active enrolment once the prospect's `stage` hits any `stop_on_stages` (reason `stage_reached`). stage sequences exit when the prospect LEAVES the trigger stage (reason `stage_change`), so stop_on_stages is ignored there. A separate `converted_company_id` exit (prospect→client) is written in the source but NOT deployed as of 2026-07-28 (Serafim, `serafim-nurture-conversion-exit.md`); redundant while `closed` catches conversions (all converted prospects are at stage `closed`).

**EXIT GAP found live 2026-07-28 (CRITICAL, not yet fixed):** the stop-on-stage exit reads `installer_prospects.stage` by `ghl_contact_id`, but **funnel-enrolled contacts have NO `installer_prospects` row** (verified 0 of 2 active enrollments matched). So booked/closed/lost NEVER fires for funnel leads, they keep getting emails after booking (James booked, was not exited, had to be Stopped by hand). The exit LOGIC is generic and correct; the DATA is missing. Fix is generic (not per-funnel): the GHL→installer_prospects sync must cover EVERY nurture-enrollable contact keyed by `ghl_contact_id`, kept current on stage change, ideally via a generic "contact stage changed" GHL webhook that upserts `installer_prospects(ghl_contact_id, stage)` for any contact. Serafim owns this. Same gap blocks the converted_company_id exit.

**Timing (important):** the engine schedules `next_send_at = enrolled_at + delay_hours`, i.e. `delay_hours` is CUMULATIVE from enrolment, NOT from the last send (so a delayed send can't snowball the run). The `SequenceEditor` UI edits a RELATIVE gap ("Nh after the previous email") and stores the cumulative sum, so editing one gap shifts the following steps' `delay_hours`.

**Sends:** `nurture-run` cron ~every 20 min, reconcile then tick; only 08:00-20:00 Europe/London; via Resend with own sender + List-Unsubscribe; checks global `email_suppressions` before enrol and send; claim-before-send so overlapping runs never double-send.

**Unsubscribe:** `api/nurture-unsubscribe.js` (per-enrolment token). One click adds the email to global `email_suppressions` AND stops every active enrolment for it, so they leave ALL nurture mail. RFC 8058 one-click compliant. See [[project_greentide_inhouse_forms]], [[reference_resend_installer_sends]].
