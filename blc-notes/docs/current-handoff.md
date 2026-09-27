# Handoff, 2026-09-25

## READ THIS FIRST (carried from 2026-09-23)

`~/code/BLC` is the live project. `~/Documents/BLC` is a rollback only: offer to delete it on or
after **2026-10-07**, if two weeks here with nothing missing. Never delete silently.

## What we worked on
- Manage Clients board (#1015, #1016): approval cards merge (`mergeApprovalCards` in
  `src/lib/onboardingChecklist.js`), website card follows `hub_clients.status` (`siteStage`),
  drags write the site status (`useClientOnboarding.moveOne`), empty note shows "Awaiting sign-off".
- Site page Status dropdown: 7 plain stages over raw values (`StatusSelect.jsx`).
- Onboarding emails section moved to the bottom of `ClientCard.jsx`.
- Legal elements (#1017): Heat pump / Solar guides (`ProductGuide` in `LegalElements.jsx`),
  solar £7,000 (£109/mo), heat pump £4,000 after grant (£63/mo), clients show only what they sell
  (`productsFor`).

## Current state
All merged and live (verified via Vercel alias). Core sits in Awaiting client approval with Website + Google pills.

## Next steps
1. Charlotte to sign off the grant facts on Legal elements (#1018 live: no line under a plain price, monthly price out of the legal block, every block editable in place via `data.overrides`).
2. Confirm which March the £9,000 oil/LPG BUS uplift ends.

## Decisions and open questions
- Realtime is only on `client_onboarding`; `hub_clients`/`crew_deliverables` listeners never fire (reload needed).

## Working tree and other sessions
marketing-agent main: clean; other session has since pulled (at 87db6ac1).
`wt-core` worktree (`fix/audit-client-questions`) belongs to another session, left alone.
