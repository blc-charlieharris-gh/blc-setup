---
name: project-harvard-site
description: Harvard Renewables CREW site (09-28): Renerji design, live harvard-renewables.vercel.app, branches merged 09-28 (#1097 logo tool, #1098 site)
metadata:
  type: project
---

Harvard Renewables website built 2026-09-28 in `website-factory/clients/harvard-renewables/` from a copy of the churned Renerji site (source archived at internal-installrhub/internal-hub/CustomSites/renerji), on Charlotte's instruction. Live on Vercel project `harvard-renewables` (blc-promotions): https://harvard-renewables.vercel.app. Facts in `_client/FACTS.md`, content audit in `_client/AUDIT-2026-09-28.md`, handoff `.claude/docs/handoff-harvard-2026-09-28.md`.

Decisions: Kent-first (Bill wants oil/LPG £9,000 areas, not London; Hub coverage TN), air con IN, solar OUT, Warm Homes Local Grant shown before Bill confirmed contractor status. Harvard never answered the website onboarding questions (invite bbzRfHuezMCr unconsumed).

Merged 09-28: #1097 SiteLogoPanel.jsx (logo tracer on /sites/:id Set up, download only), #1098 the site. Worktrees and branches removed. Redeploy from the main checkout folder (.vercel link copied there).

**Why:** second website build after Core Electrics; next step is the Hub audit (needs end_domain set).
**How to apply:** redeploy with `vercel deploy --prod --yes --scope blc-promotions` from the folder; small source logos trace better upscaled first. See [[project-core-electrics-site]], [[reference-client-site-vercel-deploy]].
