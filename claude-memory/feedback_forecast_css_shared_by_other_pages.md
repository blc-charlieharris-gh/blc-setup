---
name: feedback-forecast-css-shared-by-other-pages
description: installrhub.com css/forecast.css is loaded by webinar + breakdown pages AND a marketing-hub prototype from the live URL; check all before removing rules
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9d616766-6939-4afe-9104-e5d068462ded
  modified: 2026-09-25T07:27:42.469Z
---

`css/forecast.css` on installrhub.com is not forecast-only. It is loaded by /forecast, /forecast/reveal, /breakdown, /breakdown/resources, /webinar, /webinar/thank-you, /webinar/hero-options, and by `marketing-hub/marketing-agent/design-handoff/forecast-voice/public/index.html` straight from `https://www.installrhub.com/css/forecast.css`.

**Why:** the 09-25 dead-CSS tidy (PR #79, ~1,100 lines) only stayed safe because the prototype's classes were added to the "in use" corpus; known-issues notes had also gone stale (they called `rv-scale-*` live when the slider had been rebuilt as `rv-hero-scaler`).

**How to apply:** before removing forecast.css rules, grep the whole repo plus that prototype, then pixel-diff full-page screenshots of every page above at 1440 and 390 (force lazy images to load, hide iframe contents, disable animations, use pixelmatch threshold 0.1, else baseline is flaky). Same session: Meta Lead guard in js/consent.js is now per-page `ih_lead_fired:<path>`. See [[project-installrhub-site-audit-cleanup]].
