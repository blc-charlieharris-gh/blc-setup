---
name: project-serafim-package-picker-handoff-2026-09-18
description: RESOLVED 2026-09-19 — Serafim's side (marketplace/retainer/both + routing to the internal picker) is done and confirmed working
metadata: 
  node_type: memory
  type: project
  originSessionId: 696dfa91-015b-4c1c-8308-6a8e631cf4a2
  modified: 2026-09-19T12:29:51.426Z
---

**RESOLVED 2026-09-19.** Serafim changed the plan from "add 4 fields to his picker" to "his
system only tracks marketplace/retainer/both, everything else is the hub's own domain" — see
`marketing-agent/src/pages/hub/OnboardingPicker.jsx` (`/onboarding-picker?company_id=`, built
2026-09-18/19, not in the sidebar). Charlotte has visually confirmed his side routes to it
correctly. Nothing further outstanding here.

Full handoff doc: `marketing-agent/docs/serafim-2026-09-17-package-picker-and-invite-link.md`
(committed + pushed on branch `docs/session-handoff-2026-09-17`, PR not opened as of 2026-09-18 —
Tier-2, touches `supabase/migrations/**`, needs Serafim's review before merge). Charlotte has
passed the note to Serafim as of 2026-09-18.

Two asks, both in the sales dashboard repo (`app.installrhub.com`, Vercel project
`installrhub-dashboard` — NOT checked out anywhere on this machine, confirmed via a filesystem-wide
search, so this repo can only hand off, never verify or fix directly):

1. **Package picker needs 4 new fields**: `services.*`/`upsells.*` (per-deliverable checkboxes,
   may already exist, unconfirmed), `tech.{heatPump,solar}` (retainer-only, informational),
   `retainerMonths` (3/6 quick-picks + custom "other"), `guarantee` (£, retainer-only, default 120),
   `surveysCount` (integer, brand-only, default 10). The hub's own mirror of this vocabulary
   (`src/lib/onboardingPackages.js`) already defines the full shape — nothing new to build there.
2. **"Generate onboarding link" bug**: must atomically write BOTH `client_onboarding` and
   `onboarding_invite_tokens`, or the hub's 15-min welcome-email cron
   (`api/onboarding-email-cron.js`) has nothing to send against and silently never fires. Verify
   with `GET /api/onboarding-email-cron?dry=1`.

**Why:** Charlotte's ask, verbatim: "sales need to pick out of the packages they sold the specific
deliverables and if retainer what guarantee has been offered, let them change number of surveys
given away on the brand package from default 10 as well... then, the generate onboarding link
needs fixing to ensure it both creates the link and sends the email to the client."

**How to apply:** when this comes back from Serafim (or a resumed session asks "is the package
picker done"), check whether `companies.packages` on a fresh test invite carries non-default
`guarantee`/`surveysCount`/`retainerMonths`/`tech` values, and whether a fresh onboarding link
shows up in the cron's `?dry=1` output. Don't assume done from a verbal confirmation alone — see
[[feedback-verify-dont-trust-search-snippets]].

Also fixed on the hub side already (2026-09-18, no longer waiting on Serafim for this part): a real
bug where `retainerMonths` outside the 3/6 preset silently clamped to 3 — see
[[feedback-preset-list-not-validation-allowlist]].
