# Handoff, 2026-09-30

## READ THIS FIRST (carried from 2026-09-23)

`~/code/BLC` is the live project. `~/Documents/BLC` is a rollback only: offer to delete it on or
after **2026-10-07**, if two weeks here with nothing missing. Never delete silently.

## What we worked on
- IH webinar campaign `120250485863060731` (act_7095438517245067): ad set `120250485863400731`
  set to broad via the Meta API from `meta-access` (`meta_api.py`). 3SEC-ALLVIDEOS-TOF removed,
  renamed `Webinar - Broad`. Registrant exclusion, UK, 25-65, FB+IG only (no Audience Network) unchanged.
- Day 1 check: the Hub had 4 sign-ups by 11:00 (3 fb/ig, 1 no source), while Meta credited 1, then caught up.

## Current state
Done and live, read back from Meta. Delivering (£9.97 by 11:25).

## Next steps
1. Around 2026-10-01: compare Meta Webinar Registrations with the Hub
   (`sales_lead_intake_events`, tags `webinar-oct2026` / `webinar-oct2026-completed`).
2. If Meta stays well under, consider a server-side Lead on webinar form submit (offered, not requested).
3. Carried from 09-25: Charlotte to sign off the grant facts on Legal elements (#1018), and
   confirm which March the £9,000 oil/LPG BUS uplift ends.

## Decisions and open questions
- Broad targeting was Charlotte's call on 09-30.
- The thank-you Lead is consent-gated (`installrhub-static/js/consent.js`, `IH_TRACK_LEAD`):
  16 link clicks gave 1 landing page view, so Meta sees only some sign-ups.

## Working tree and other sessions
Clean: meta-access main matches origin, no repo files changed. blc-39 (marketing-agent) was
told about the targeting change and this handoff.
