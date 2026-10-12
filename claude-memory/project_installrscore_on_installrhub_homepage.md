---
name: project-installrscore-on-installrhub-homepage
description: Site / Social / Search scores (InstallrScore) are coming to the installrhub.com homepage; crew.installrhub.com is internal-only and its public pages redirect to installrhub.com (Charlotte 2026-10-11)
metadata:
  node_type: memory
  type: project
  originSessionId: 0283fc76-20ea-48be-8226-5101255d523d
  modified: 2026-10-11T08:22:13.766Z
---

Charlotte 2026-10-11: "we will bring in site, social, search score onto the homepage" of installrhub.com (repo `site-installrhub/installrhub-static`). The InstallrScore is the site audit sold in the Brand Package (also used to warm up prospects); the free score / lead-gen front door moves from crew.installrhub.com to the main site.

Same day: crew.installrhub.com is "an internal page only really". Its public landing (`/`), `/book-a-demo` and `/booked` now redirect to installrhub.com (`/`, `/book-a-demo` -> `/book-discovery`, `/thank-you`); only clients' personal pages (`/<slug>?k=`), token pages and the static `/sitescore/<slug>/` audit pages stay on crew.

**Why:** one public front door (installrhub.com); crew is where clients see their own work.
**How to apply:** tell the next site-installrhub session at its start (it owns the homepage build). When planning it: the old crew landing form posted to an endpoint that never existed, so build a real receiver (e.g. `site_audit_prospects`, made for this, 0 rows) with rate limiting; one scoring rubric (crew audit C21: three tier scales exist, pick one, put it in Parameters). Related: [[project_hub_page_audit]], [[feedback_public_by_link_pages_rule]].
