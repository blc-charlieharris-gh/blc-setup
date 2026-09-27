---
name: project-weekly-reports-forum-ceiling
description: "UK trade forums yield ~3-4 installer business-pain posts a week, too few for pattern counts; B2C forum data works fine"
metadata: 
  node_type: memory
  type: project
  originSessionId: b19fab95-e88f-49fe-ba7d-476d91139709
  modified: 2026-08-07T14:01:24.860Z
---

Measured 2026-08-07 in `blc-charlieharris-gh/weekly-reports` (`scripts/collect-forums.mjs`, rewritten to count themes over a rolling 28-day window instead of quoting a handful of threads).

**B2C works.** MoneySavingExpert gives ~310 homeowner posts per 28 days, ~84 tagged across the taxonomy. Top themes are real: servicing/breakdowns 8.7%, smart tariffs 7.1%, switching supplier 7.1%, batteries 5.8%, energy bills 5.5%. Good enough for weekly hook and objection tracking.

**B2B does not.** ElectriciansForums + UKPlumbersForums together yield only ~107 posts per 28 days, of which ~14 are business pain. That is 3 or 4 a week. Verified as a real ceiling, not a crawler bug:
- Only the `whats-new/posts/` view returns current posts; it caps at 50 threads and ignores every page parameter tried.
- The targeted boards (Business Related, Solar Panels, Renewables) are genuinely stale. EF Business Related's top thread last moved in May 2026. Timestamps that look recent on a board page are a forum-wide sidebar widget, identical across boards.
- Most trade-forum chatter is technical Q&A (wiring, boiler faults), not marketing or business pain.

**Do not "add more sources" reflexively.** Already ruled out this session: Reddit API (2026 policy needs prior approval, free tier non-commercial), Google Search Console (only reports queries the site already ranks for; GT traffic is paid social, returned 3 clicks), Bing Webmaster (no Microsoft account), Google Ads keyword volume (needs developer token approval), BuildHub (topic links not exposed in a scrapeable shape). See [[feedback-verify-dont-trust-search-snippets]].

Better B2B pain sources, none built yet: Trustpilot/Google reviews of lead-gen competitors (public, at volume, but objections only, no hooks), and Charlotte's own sales-call and churn notes (unique, free, richest, not yet captured anywhere).

Related: [[project-client-weekly-reports]], [[feedback-silent-fallbacks-hide-dead-features]].
