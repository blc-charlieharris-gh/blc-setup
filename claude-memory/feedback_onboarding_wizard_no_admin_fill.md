---
name: feedback_onboarding_wizard_no_admin_fill
description: No admin/staff way to fill the client onboarding wizard on their behalf without risking the auto client-facing email; no suppress flag exists
metadata: 
  node_type: memory
  type: feedback
  originSessionId: ad53e556-fee9-4b5c-b917-5e622e603d6a
  modified: 2026-08-27T07:14:06.831Z
---

There is no admin-side onboarding form. The only wizard is `src/pages/public/ClientOnboarding.jsx`
(marketing-agent), client-facing, gated by a signed invite token, mounted outside auth. Staff preview
via `?core=`/`?website=`/`?host=` query params shows the form with no token, but submission is
explicitly blocked without one (`ClientOnboarding.jsx:364-372`, "Preview only... use the link we
emailed you") - so preview-and-save is not possible.

**Why this matters:** filling in the client's real invite link yourself is indistinguishable from the
client submitting it. The "onboarding complete" email is fully automatic (Vercel cron every 15 min,
`api/onboarding-email-cron.js` + `onboardingEmails.js`), firing the moment `hasSubmitted()` is true -
defined as `checklist.form_submitted === true` OR `companies.onboarding_answers` non-empty
(`onboardingEmails.js:367-368`). There is no per-client mute/suppress/dry-run flag anywhere in this
path (checked `onboardingEmails.js`, `onboarding-email-cron.js`,
`onboarding-mailer-data/index.ts`, `useClientOnboarding.js`). The only dry-run is `?dry=1` on the cron
endpoint itself, which is global, not per-client.

Trap: even the **kanban board** (`OnboardingBoard.jsx` / `useClientOnboarding.js`) can trigger this by
accident - dragging a card past "awaiting_form" sets `checklist.form_submitted = true` with zero real
answers collected, which is enough to fire the client-facing "complete" email on the next cron run.

**How to apply:** if a client onboarded verbally/by phone and staff need their answers on record without
the client getting an email, there is currently no safe path in the app. Either accept the email will
go out (may be fine/expected), get engineering to add a per-client suppress flag first, or write the
answers into `companies.onboarding_answers` / `client_onboarding` directly at the DB layer outside the
form flow (Supabase MCP here is read-only, see [[feedback_supabase_mcp_read_only]], so this needs doing
from elsewhere). Don't just fill in the real form or nudge the kanban card assuming it's inert - both
can email the client. See [[project_onboarding_emails]], [[project_client_onboarding_engine]].

**Applied precedent (2026-08-19):** LW Heating was onboarded exactly this way, a direct SQL patch
creating the `client_onboarding` row + status flip + checklist ticks + pre-seeded "sent" rows in
`onboarding_emails` so the mailer stayed silent. See [[project_lw_heating_manual_onboarding]] for
the exact pattern and a real gotcha it surfaced (`client_onboarding.company_id` is unique, so a
later real close for the same client will fail if a row already exists).

**Applied precedent #2 (2026-08-26):** Helix Power Ltd, closed on the app but the checklist came
through empty despite a real form submission + booked call. Same pattern, checklist ticks only
(the `client_onboarding` row already existed from the app close) plus a pre-seeded "sent" row for
just the `complete` email variant (the only one `hasSubmitted()` would have fired once
`form_submitted` flipped true; welcome/chaser were never at risk since no
`onboarding_invite_tokens` row existed for the company). Confirmed via `onboardingEmails.js`'s
`dueOnboardingEmails()` logic before patching, not just by pattern-matching the LW Heating case.
