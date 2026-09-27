---
name: project_intake_forms_retired
description: "Both hub intake forms retired 2026-07-31; CREW one deleted, legacy website one frozen but MUST stay live for 2 outstanding links"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2d7508d9-d165-4c26-9ed8-fe15e093f40f
  modified: 2026-08-06T13:20:47.044Z
---

Both marketing-agent intake forms were retired on 2026-07-31 in favour of the onboarding engine
Charlotte and Serafim are building in the app (see [[project_client_onboarding_engine]]).

**CREW intake form: DELETED.** `ClientIntake.jsx`, `api/crew-intake.js`, `api/crew-intake-logo.js`,
the `/:slug/intakeform` route, the "Send intake form" button, and the never-invoked `crew-intake`
edge fn. It had never persisted a single submission since shipping 25 July: `SUPABASE_SERVICE_ROLE_KEY`
was never set on Vercel, so it returned a fake `200 {ok:true,persisted:false}` and still showed
"Thank you, that's everything". No client link was ever sent, so nothing was lost.

**Legacy website intake (`/intake/:token` → `hub-intake-public`): STILL LIVE, do not remove.**
Two links are out and must keep working until both leave status `draft`:
- `88b31a6854304e9bb9a4b23fa934be33` → Gas Worx
- `1047f954a6cc4f9685e33e64a5ec740e` → LW Heating Ltd
**STOP-GAP REOPENED 2026-08-06 (#509), because the retirement was slightly early.** Onboarding
still cannot take a website-build client end to end (its completion step saves nothing), so SWH
Electrical was signed with no way to send us details. `IntakeLinkPanel` now offers **Issue an
intake link**, and `issueIntakeToken(id)` was added to `clientCrudSlice`. Narrow by design:
FIRST link only, **draft status only**, never regenerates, no email (staff copy and send it).
Condition-based, not client-specific, so any future draft build sees it too.
**Charlotte's decision: retire this option once onboarding goes live properly.** Both the button
and the slice method carry a delete-me comment. Verified 2026-08-06: `hub-intake-public` v23
ACTIVE (probed with a bogus token, returns 401 "Link unavailable"), and Gas Worx submitted
through this path for real.

Otherwise still retired: no emails, no regeneration, `createClient` and CREW's
`ensureWebsiteBuild` still do not mint `intake_token`, `regenerateIntakeToken`/`sendIntakeEmail`
stay removed. **Trap: do not change a waiting client's status**, the edge fn only accepts
`draft`/`intake_sent` and 409s otherwise, killing their live link.

**Why:** shipping a form that lies about saving is worse than no form, and onboarding should live in
one place, not three.

Shipped in #470, merged and verified live 2026-07-31: `/api/crew-intake` and `/api/crew-intake-logo`
now 405 (gone), the two client links still return 200, and `hub-intake-public` still validates.
Charlotte deleted the orphaned `crew-intake` edge fn herself. §7 of `serafim-onboarding-handoff.md`
had told Serafim to retire the WRONG form; corrected in the same PR before he acted on it.

**How to apply:** never delete `/intake/:token`, `hub-intake-public`, `intakeSchema.js` or
`intakeApi.js` while the stop-gap button can still issue links. The old condition (wait for
Gas Worx + LW Heating) is now MET and must not be acted on: Gas Worx submitted (status
`intake_complete`) and LW Heating is no longer a `hub_clients` row at all. Deleting on that
basis would strand SWH Electrical. `crew_clients.intake` is a COLUMN
that stays: `api/crew-generate.js` reads it for social brand voice (services, about, tone, usp,
dosDonts, links), so the onboarding form must populate it, tracked as B11 / §6a in
`docs/serafim-onboarding-handoff.md`. Also note `SUPABASE_SERVICE_ROLE_KEY` is STILL absent from
Vercel, which silently breaks `notify-signoff.js`, `site-audit.js`, `emails-overview.js` and
`nurture-unsubscribe.js`. See [[feedback_silent_fallbacks_hide_dead_features]].
