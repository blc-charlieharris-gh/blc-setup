---
name: reference-installrhub-track-js-attribution
description: "How installrhub.com's track.js derives ih_channel and why it persists onto every page including thank-you pages; where to look when tracing a specific B2B lead's source"
metadata: 
  node_type: memory
  type: reference
  originSessionId: c8ed8129-d200-41a1-b91c-cfea43b2604b
  modified: 2026-09-17T07:13:01.498Z
---

`installrhub-static/js/track.js` (see [[reference_installrhub_git]] for the repo location/gotcha)
is the ONLY place `ih_channel`/`ih_landing`/`ih_referrer`/`ih_place` get computed for installrhub.com.
`src/lib/sources.js`'s `previewChannel()` in marketing-agent is a deliberate MIRROR of this file's
`deriveChannel()`, not the source of truth — read track.js directly for the real logic.

**`deriveChannel()` order** (first match wins): (1) explicit `utm_medium`/`utm_source` rules
(paid vs organic per medium); (2) `document.referrer`'s hostname against known search/social host
lists; (3) a fallback: if `fbclid`/`li_fat_id`/`twclid` is present on the URL, "organic-social"
even with no referrer (in-app browsers strip it, but the click-ID still proves the platform); (4)
otherwise "direct". **A blank referrer AND no click-ID means the platform is genuinely
unknowable** — don't assume a specific platform (e.g. LinkedIn) just because that was someone's
working hypothesis; check `raw ? 'li_fat_id'` / `raw->>'fbclid'` etc. in `sales_lead_intake_events`
explicitly before concluding.

**Why `ih_channel` shows up on `/thank-you` URLs**: `track.js` runs on every page and does two
things with NO per-page exclusion list: `decorateAll()` rewrites every same-origin link to carry
the visitor's persisted first-touch params, and `syncUrl()` writes them into whatever page is
currently loaded via `history.replaceState`. Both exist so the homepage/`/contact`'s embedded
Fillout forms (`data-fillout-inherit-parameters`) can read attribution off the parent URL — that's
the ONLY consumer. Thank-you pages have no form, so the params there are pure side-effect, not a
bug in the classification logic itself. See known-issues.md (marketing-agent, 2026-09-17) for the
open question of whether to add an exclusion.

**How to trace a specific B2B lead's source**: query `sales_lead_intake_events` by
`ghl_contact_id` (find it via `installer_prospects.ghl_contact_id` matching on `contact_name`),
read `raw` (full GHL webhook payload — has `ih_channel`, `ih_landing`, `ih_referrer`,
`ih_placement`, `utm_*`, `fbclid`, and GHL's own workflow fields like "Converted Page"). If the
workflow name in the row is a re-engagement/tagging workflow (e.g. "Incoming Existing lead ->
Tags") rather than the original intake form, this may not be their FIRST touchpoint — the row
that actually set `ih_channel` (first-touch-only, never overwritten per track.js) could predate
what's in this table for them entirely.
