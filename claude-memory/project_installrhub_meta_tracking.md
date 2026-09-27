---
name: project_installrhub_meta_tracking
description: "InstallrHub breakdown-funnel Meta conversion tracking — the Fillout over-count bug, interim fix, and server-side CAPI target once forms move in-house"
metadata: 
  node_type: memory
  type: project
  originSessionId: 47f31c75-96a5-4b13-87cf-6477edb0e6ae
---

InstallrHub `/breakdown` funnel Meta tracking. Full spec: `site-installrhub/docs/reference/meta-conversion-tracking.md`.

**The 2026-07-23 bug:** Meta reported 4 conversions for 1 real submission. Cause = the "Resources Lead" custom conversion was "All URL traffic + URL contains /breakdown/resources", which counts every PAGE LOAD of the thank-you page (refreshes, direct hits, our own test loads), not submissions. NOT the multi-event theory I first floated: the `Fillout.FormSubmitted` event carries `event_source_url = installrhub.com/` (site root), so it never matched the /resources URL rule anyway.

**Pixel:** only tracking code on the whole site is `installrhub-static/js/consent.js` — consent-gated, pixel ID `6022454534459147`, fires only `PageView`, no `Lead` event. Breakdown Fillout form id = `uuQa3hizuxus` ([breakdown/index.html:172](installrhub-static/breakdown/index.html#L172)).

**Interim fix (IMPLEMENTED 2026-07-23, not the Fillout route because we're leaving Fillout):** fire our OWN standard `Lead` from the thank-you page via the existing consent pixel loader. `breakdown/resources/index.html` head sets `window.IH_TRACK_LEAD=true`; `js/consent.js` loadMetaPixel fires `fbq('track','Lead')` after PageView when that flag is set, guarded by `sessionStorage['ih_lead_fired']` (stops refresh re-fire). Meta side DONE 2026-07-23: created custom conversion `Lead-ResourcesFunnel` (Event=`Lead`, Rule=URL contains `/breakdown/resources`); duplicated+reset the campaign to optimize on it (fresh campaign, not the old URL-CC one). Optimize on the CUSTOM CONVERSION not raw standard Lead, because more in-house forms are coming and each fires a standard Lead; URL scoping keeps this campaign on the breakdown funnel. Deploy of the site code = direct push to main (NOT Serafim-gated for site-installrhub static, Vercel auto-deploys). This same Lead fire moves server-side for CAPI later (nothing thrown away). Note: does NOT stop the other events firing, just stops them being counted. Meta does NOT let you edit an existing CC's rule.

**Verify without Test Events (too laggy):** DevTools Network tab, filter `tr?`, count `facebook.com/tr` requests and read `ev=`. Fillout dashboard = ground-truth submission count.

**Target (forms moving off Fillout into Supabase, I'm building them):** own form → `POST /api/lead` (Vercel fn exists) → insert Supabase (source of truth) + fire Meta **CAPI** standard `Lead` server-side. Dedup browser+server via shared `event_id`; hashed email/phone; pass `_fbp`/`_fbc`+IP+UA; optimize on `Lead`. Retire the Fillout CC when it ships. Same shape as [[project_greentide_inhouse_forms]] (own form → /api/lead → n8n → lead_intake_events).
