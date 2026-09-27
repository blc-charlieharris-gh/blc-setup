---
name: feedback_onboarding_form_dead_controls
description: "The client onboarding form was full of controls that looked real and did nothing; when a client reports something 'not working' there, check whether it was ever wired at all before debugging behaviour"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c91c1782-3fca-4ce8-a167-29b62433e2ae
  modified: 2026-08-11T08:42:40.381Z
---

Walking the onboarding form end to end on 2026-08-07 found **six** controls that looked
functional and were not wired at all:

- The Facebook "how to invite us" video: a play-button graphic over a gradient, no video.
- "Copy" beside the Meta invite address: a `<span>`, not a button.
- "Skip for now" on the team step: the component took an `onSkip` prop the page never passed.
- The kickoff calendar: a placeholder whose "Pick a time" button set `booked` from the CLICK, so
  the thank-you screen told people who never booked that they were booked.
- `leadDelivery` (how they want leads sent): submitted, and no server writer reads it. Never
  stored since the form shipped.
- `onboardingCall`: never even sent to the server.
- **A seventh, found 2026-08-11: the T&Cs acceptance checkbox.** `register-installer` never reads
  `acceptedTerms` (the string is absent from the deployed function). It looks up the latest
  `tcs_versions` row itself and stamps `tcs_accepted_version` regardless, commented "so the new
  company starts accepted". So every company was recorded as having accepted whether they ticked or
  not, and the existing `tcs_accepted_version = 1` rows prove nothing. The step was also shown to
  EVERY package while the only terms we have are marketplace ones (credits, claiming leads), so ads
  and website-only clients were accepting terms that did not apply. Terms step removed 2026-08-11;
  the server-side stamp is still there and is on Serafim. See [[project-onboarding-emails]].

**Why:** every one fails silently. The client cannot tell "this does nothing" from "I did it
wrong", and we get no error either. Same family as
[[feedback_silent_fallbacks_hide_dead_features]].

**How to apply:** when Charlotte reports something on this form "not working", first check
whether it was ever wired, before debugging behaviour. Grep for the handler prop at the CALL
site, not just the component. For anything the form collects, check a server writer actually
reads that key: `register-installer` keeps the whole request body, so an unread key is silently
discarded with no error.

**The guard that should have caught the data ones** (`ClientOnboarding.test.js`, "every collected
field is submitted") was **silently not running**: it dies on collection without Supabase env,
and `vercel env pull` writes `VITE_SUPABASE_URL` empty, so 31 tests were skipped on every
machine. Fixed by stubbing the values in the `npm test` script. Run `npm test`, not
`npx vitest run`, or those 31 vanish again.
