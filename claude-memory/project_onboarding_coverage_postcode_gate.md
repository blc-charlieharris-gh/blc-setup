---
name: onboarding-coverage-postcode-gate
description: Core Electrics got stuck unable to submit client onboarding; root cause was a client-side UI gate never checked against a server-side requirement added weeks later in a different repo
metadata: 
  node_type: memory
  type: project
  originSessionId: 77be0303-d4e8-4b17-824c-c4eec76035c9
  modified: 2026-09-14T08:16:45.477Z
---

Core Electrics (package `leads: true`) got stuck on the last page of `/client-onboarding`,
unable to submit, seeing "Please select at least one postcode area" with no visible way to fix
it. Root cause, found 2026-09-14 in `marketing-agent`: `BasesCoverage.jsx`'s area picker
(nation tiles + the postcode-areas free-text list) only rendered once the separate "Postcode for
this base" field was non-empty (a 2026-08-14 design choice). `validateBases` (client-side) only
required postcode OR areas, so a base with just a postcode and zero areas passed every step
silently. Weeks later, 2026-09-07, `register-installer` (a different repo, the Green Tide
Dashboard) added a hard requirement that `postcode_areas` be non-empty for any package with
`leads: true` or `is_marketplace: true`. Nobody connected the two, so the failure only
surfaced on final submit, on the last page, far from the actual missing field.

Fixed same day: PR #766 removes the postcode gate (area picker always renders; only the radius
method still needs a postcode), PR #767 swapped the postcode field's placeholder off a real
staff home postcode (`BB7 9ZN` → `SW1A 1AA`) since it's a public form. Both verified live via
Puppeteer. Full detail in this repo's `.claude/docs/known-issues.md` (Fixed section) and
`CHANGELOG.md` 2026-09-14.

**Why:** this is the same failure shape as [[feedback_onboarding_form_dead_controls]] and
[[project_onboarding_location_picker_silent]] — a control that looks reachable but isn't, this
time because a client-side gate and a server-side requirement were built independently, in two
different repos, with no shared test connecting them (`BasesCoverage.jsx` has no test file at
all, only the underlying lib functions do).
**How to apply:** when a client reports being stuck on the LAST page of onboarding with an error
that names an EARLIER step's data (coverage, products, etc.), suspect this shape: client-side
per-step validation passed, but a server-side check (in `register-installer`, a different repo)
rejected the actual submission. Check the edge function's source directly
(`mcp__supabase__get_edge_function`) rather than assuming the bug is wherever the error text
points on screen.
