---
name: project-core-electrics-site
description: "Core Electrics (Oldham) site forked from SWH on 2026-09-23, rebranded Core Electrics & Renewables, all copy merged (#984/#987) and live, client info pending"
metadata:
  node_type: memory
  type: project
  originSessionId: 2eb85121-7db1-47ba-b989-ee3c914209db
  modified: 2026-09-24T08:52:47.490Z
---

Core Electrics Ltd (hub_clients `core-electrics-ltd`, Oldham, company 13847334) website was built 2026-09-23/24 in `website-factory/clients/core-electrics/`, forked from SWH on Charlotte's instruction ("use swh electrical as template"). Their current live site is https://www.coreelectricsltd.co.uk (New World Digital Media). The Hub intake had the Gmail address in the site_url field.

The fact sheet is `_client/FACTS.md`, and the site may quote nothing beyond it. Reviews: only the two real Google reviews Charlotte supplied 2026-09-24 (Steve Kneale, Vivienne Dean), in a band under the home hero plus a "5-Star Rated Excellent on Google" hero badge; no counts or rating schema. Their address is postal only, so there's no map. Page headers use option A (charcoal with a copper glow), Charlotte's pick. Deployed 2026-09-24 as Vercel project `core-electrics` → https://core-electrics.vercel.app. Rebranded "Core Electrics & Renewables" (Barlow fonts). All of Charlotte's page copy (home, about, 5 service pages, quote) merged by 2026-09-24 (#984, #987) and deployed. Round 2 (merged 2026-09-24): wider text site-wide, coloured headline part always on its own line, dark legal bar, home footer CTA = "Take Control" (the "One Number" band was dropped). Preview-page homepage shot comes from re-running the Hub audit (#989). No FAQ or finance pages: FAQs live on each service page, finance is a section on home/solar/battery/heat pumps. Round 3 (2026-09-25, merged + live): hero "Powering Homes Across the North. Core Handles It All.", ONE area list site-wide (every service in every area, no electrical/renewables split), home Google map centred on Oldham (consent-gated, NOT the postal address), compact home steps + "Prefer to Talk?" card, og:image JPG on the final domain (shows only once the domain moves). Still waiting on the client for FCA finance wording, heat pump photos, domain and their own Web3Forms key.

**Why:** a second client build (Harvard Renewables) comes next, and Core's remaining asks are listed in meta.json's note.

**How to apply:** redeploy after edits with `vercel deploy --prod --yes --scope blc-promotions` from the folder, see [[reference-client-site-vercel-deploy]]. The Hub audit needs end_domain `coreelectricsltd.co.uk` set first. Related: [[project-swh-transfer-handover-2026-09-18]].
