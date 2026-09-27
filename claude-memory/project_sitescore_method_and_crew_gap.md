---
name: project_sitescore_method_and_crew_gap
description: "How the hand-built SiteScore+SocialScore is made, and why it can't yet fold into the CREW auto-engine"
metadata: 
  node_type: memory
  type: project
  originSessionId: 86e40a14-f3ce-4a10-b20f-32a5c513b4d6
---

Full method write-up: `meta-access/outputs/sitescore-hqgroup/METHOD.md`. The hand-built audits (Arktek, HQ Group) are the quality bar CREW must hit. Goal (Charlotte, 2026-07): once SocialScore is signed off, build EXACTLY the hand-built audit into the CREW engine.

**The audit is now tabbed: SiteScore + SocialScore on one page** (installrhub.com/sitescore/<slug>, deploy via PR to installrhub-static, never self-deploy). See [[project_sitescore_audits]] and [[feedback_sitescore_unbiased_scoring]].

**Why the hand-built version can't just drop into CREW today (the gaps to close):**
1. **Screenshots.** Hand-built uses headless Puppeteer (in site-greentide/post-booking) for real per-section, distinct shots. CREW's `api/crew-audit.js` uses keyless Microlink and gets ~2 shots, which is the "same screenshot 3 times" complaint. CREW needs a headless-browser screenshot step (a serverless fn can't run Puppeteer easily; needs a browser service or a separate worker).
2. **Deep tech-layer + baked-image detection.** Hand-built reads raw HTML for CMS/builder/schema AND detects content baked into images (offer/prices/phone as pixels = killer finding). `gatherTech` exists in crew-audit.js but the baked-image detection and the depth aren't there.
3. **Real social data.** Hand-built pulls live Meta Graph (followers, cadence, engagement, reviews, post images). CREW's social gather is thin; needs the full Graph ingestion + the SocialScore report shape.
4. **Report shape.** CREW's CrewReport renders a single-pillar-ish report; needs the tabbed Site+Social layout with the section-sliced screenshots and the composed IG grid / stats / cadence visuals.
5. **Scoring rubric.** The de-biased, independent design/build/copy scoring must be baked into the prompt, plus structural diagnosis (e.g. subdomain/audience-split) not surface fixes.

Net: CREW is a single-pass LLM pipeline producing a generic template; the hand-built is Puppeteer + Graph + deep manual study + human-tuned scoring/copy, iterated. Folding in = add headless screenshots, Graph social ingestion, baked-image detection, the tabbed report shape, and the scoring rubric.
