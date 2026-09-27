---
name: project-swh-final-updates-2026-09-25
description: SWH site final updates 09-25 (Phoenix finance, audit clean-up) all merged; fonts + inline-script CSP deferred to just before final handover; waiting on client key and numbers
metadata:
  type: project
---

Everything was merged and deployed on 2026-09-25 (swh-electrical.vercel.app). Phoenix finance: verbatim footer disclosure, and a finance band plus calculator link on the solar and battery pages only (Phoenix covers only those; the boiler finance section was removed). Audit clean-up: descriptions, og:url, image dimensions, compression, apple-touch-icon, 7-day /assets cache with ?v= stamps, 360px overflow.

**Deferred (Charlotte): clear these just BEFORE the final SWH handover, not before.** (1) Font weight budget: 5 Poppins weights, all used, so dropping one (e.g. 500) is a small visual change. (2) CSP 'unsafe-inline': move the inline scripts (SCRIPT/FORMS_SCRIPT/FLOW_SCRIPT in build-pages.mjs, plus the hand-authored pages) into asset files, then drop 'unsafe-inline' from vercel.json and .htaccess.

**Waiting on SWH:** their own Web3Forms key (a standard question is already on the preview page), plus ICO, MCS, NICEIC and Gas Safe numbers. For those, re-run the audit, then use the new "business details" standard question in Site Detail > Ask for more details.

**Why:** Charlotte chose to leave the two Check items until final handover.
**How to apply:** at final handover, do both deferred items, re-run the audit, and check the build is idempotent (build-pages.mjs strips and re-adds the ?v= stamps; see the comment at the top of the file). Related: [[project-swh-transfer-handover-2026-09-18]], [[feedback-hotlinked-third-party-images-set-cookies]], [[reference-bus-grant-oil-lpg-9k]].
