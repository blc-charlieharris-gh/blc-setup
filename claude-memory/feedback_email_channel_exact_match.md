---
name: feedback_email_channel_exact_match
description: "Every nurture click was classified 'referral' because track.js matched email on an exact utm_medium === 'email' while the links tag email-automation; check the classifier against the ACTUAL links before trusting a zero"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 1d7c3945-3ca4-4bb5-9649-3f4c576a2a03
  modified: 2026-08-11T12:08:10.600Z
---

2026-08-11. The Email row on `/sources` read zero. It was never a volume story:
`deriveChannel` in site-installrhub `js/track.js` tested
`utm_medium === 'email'`, and every nurture link ships
`utm_medium=email-automation`. It fell past that test, past every paid test, and
out of the bottom branch ("explicit utm_source, no paid medium") as **referral**.
The retired weekly blast used `email-blast` and had the same fate.

**Why:** a channel classifier and the links it classifies live in two different
places (a JS file on the site, `nurture_steps.body_html` rows in the DB) and
nobody diffs them. An exact-match test against a value written somewhere else is
a silent failure by construction: it produces a plausible wrong answer, never an
error.

**How to apply:** when a channel, source or placement bucket reads zero, do NOT
reach for "low volume" first. Read the actual link strings, then trace them
through the classifier by hand. Then fix BOTH ends: retag at source, AND widen
the classifier, because mail already sent keeps arriving for months and you
cannot recall it. Fixed by matching the `email` prefix plus `utm_source=email`,
and `buildTrackedUrl` now warns on an email-ish link the site won't read as
email.

Second-order: a link with no `ih_place` is not neutral. `groupBySitePlacement`
defaults it to `forecast-direct`, so an unplaced email CTA reported as somebody
who walked straight onto /forecast.

See [[project_sources_tracking]], [[feedback_silent_fallbacks_hide_dead_features]].
