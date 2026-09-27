---
name: project-swh-legal-compliance-cleanup
description: "SWH Electrical legal/compliance pass (2026-09-04): RECC removed, address+VAT fixed, clean URLs; committed via PR #750/#751, merged. Web3Forms key still outstanding."
metadata: 
  node_type: memory
  type: project
  originSessionId: b8a0b3af-bca4-4fcc-bf36-47871812540c
  modified: 2026-09-04T13:00:38.942Z
---

RECC accreditation removed site-wide from `website-factory/clients/swh-electrical/` (Charlotte confirmed SWH are NOT RECC members, TrustMark substituted as the trust-signal claim instead since TrustMark, TMRN256, is genuinely correct). Registered address corrected everywhere from "Unit 2 Mandale Park" to the real Companies House address "Unit 2 Mandale Road, Wallsend Road" (verified live at find-and-update.company-information.service.gov.uk, company 09835226). Privacy Policy given a last-updated date, specific retention periods, and a Web3Forms retention note (sourced from docs.web3forms.com's own FAQ: they don't store submission content, only server logs, cleared every 2 months, a blended web search on this gave conflicting/wrong numbers, don't trust that route again for this fact). Terms given a cancellation-rights line. Whole site converted from `*.html` URLs to extensionless clean URLs.

**Gotcha hit live in production:** `vercel.json`'s built-in `cleanUrls:true` broke the homepage (404, edge-cached) via an undocumented conflict with the existing `{"source":"/","destination":"/template.html"}` rewrite. Do not use `cleanUrls` on this project again. Fixed with explicit per-page `rewrites` (serve) + `redirects` (308 `.html` → clean) instead, one pair per page, which is what's live now. If clean URLs are ever needed on another website-factory client site, use the explicit rewrites+redirects pattern from this project's `vercel.json`, not `cleanUrls`.

VAT number (GB225010663, client supplied 2026-09-04 after being asked) added to the footer (`FOOT` in build-pages.mjs) and terms.html §1 in a same-day follow-up commit.

**Committed and merged:** PR #750 (RECC/address/legal/clean-URLs) and #751 (VAT number), both to `main`, both deployed live via `vercel deploy --prod` and verified with curl against the actual production URLs, not just local build output.

**Still outstanding:** a real Web3Forms access key. `W3_KEY` in build-pages.mjs is still the deliberate invalid placeholder (must not be Arktek's real key, that would route SWH's leads into Arktek's inbox). Client isn't ready to set up their own Web3Forms account yet. Until this is done, the live Privacy Policy's claim that Web3Forms "forwards submissions to our email inbox" isn't yet true, and go-live should be blocked on this being wired up for real.

See [[project_swh_website_imagery_pass]] for the prior session's work on this same client site, and [[feedback_website_factory_manual_deploy_gap]] for why every change here needs a manual `vercel deploy --prod`, no git-push auto-deploy.
