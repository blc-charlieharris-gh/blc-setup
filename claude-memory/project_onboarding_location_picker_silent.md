---
name: onboarding_location_picker_silent
description: "Serafim's onboarding wizard location picker (PR #511) has no notification when a live client later changes their coverage areas"
metadata: 
  node_type: memory
  type: project
  originSessionId: 097ece24-1e37-4553-9e99-3718b28ecdfd
  modified: 2026-08-19T14:53:15.493Z
---

Serafim added a location/coverage picker to the client onboarding wizard, PR #511 (2026-08-06): `src/components/hub/onboarding/StepPostcodes.jsx`, `CoverageInput.jsx`, `PostcodeTagInput.jsx` in marketing-agent. Writes to `companies.postcode_areas` (array) and `coverage_mode` (text, e.g. "nationwide"/"custom"). Note: coverage_mode is a label only, matching has never used it, only postcode_areas is read anywhere.

There is no post-go-live location edit page inside marketing-agent. Live clients edit their own coverage via the `register-installer` edge function, which lives in a separate repo (Green Tide Dashboard), not yet audited. Within marketing-agent: confirmed silent, no trigger, webhook, email, audit-log row, or hub UI badge fires anywhere on a `postcode_areas`/`coverage_mode` change.

**Why:** Charlotte needs to know when a live client's service area changes (affects targeting, matching, campaign setup) but currently has zero visibility, it's a pure silent DB write, same failure shape as [[feedback_silent_fallbacks_hide_dead_features]].
**How to apply:** before building a notification, check the Green Tide Dashboard repo's `register-installer` function to confirm it's the only writer of `companies.postcode_areas` post-go-live. A DB trigger on `companies` (mirroring `20260812120000_tick_form_submitted_from_answers.sql`'s pattern) plus a hub UI flag is the natural fix, not yet built.
