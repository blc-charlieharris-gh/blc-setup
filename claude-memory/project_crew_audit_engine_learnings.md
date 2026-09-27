---
name: project_crew_audit_engine_learnings
description: Concrete gaps + techniques from hand-building the Heatzen SiteScore (2026-07-08) that must be baked into the CREW auto-audit engine
metadata: 
  node_type: memory
  type: project
  originSessionId: 5da3a23e-b254-47a3-aeeb-fed5f043d9d8
---

Learnings from hand-building the **Heatzen** SiteScore (2026-07-08, client = Proximus Solutions Ltd, two sites heatzen.co.uk + proximussolutions.co.uk). These sharpen the audit method and are the exact upgrades to fold into `api/crew-audit.js`. See [[project_crew_audit_funnel_build]], [[project_sitescore_method_and_crew_gap]].

**1. Cloudflare kills the current engine.** Heatzen sits behind a Cloudflare "Just a moment" JS challenge, so Firecrawl / Microlink / curl / WebFetch all 403. The CREW engine (Firecrawl + keyless screenshots) would return nothing for such sites. FIX: a real headless-browser step (Puppeteer) that waits out the challenge (poll title until it stops matching /just a moment|checking your browser/). This is the same "headless screenshot worker" gap the handoff already flagged, Cloudflare makes it non-optional, not just a quality nicety.

**2. Reusable capture tool built:** `site-greentide/post-booking/capture-audit.js` (Puppeteer 24). Drives a real browser, clears Cloudflare, captures desktop-1440 + mobile full/hero + scroll-sliced section shots, and dumps rendered.html + visible-text.txt + tech.json (CMS, script count, schema ld+json, GTM/GA/Meta-pixel/Trustpilot flags, h1s). Needs `protocolTimeout: 180000` + a BOUNDED waitImages (scroll-through with an 8s cap, never `await` every document.image, it hangs on lazy/never-loading imgs on heavy Elementor pages). Reuse this as the model for the engine's capture worker.

**3. Audit money pages, not just the homepage.** Heatzen's homepage is a pure ECO4 grant funnel with ZERO solar, but its `/pro-solar-solutions/` sub-page has a strong 3-package picker + a smart savings calculator (est. savings, payback, lifetime benefit). Best asset was one click too deep. The engine must crawl the money pages and detect a strong-asset-in-the-wrong-place ("your best hook is buried") as a finding.

**4. Detect trust-asset UNDER-USE, not just presence.** Heatzen has 4 stars / 305 Trustpilot reviews but the homepage shows only a plain "Review us on Trustpilot" COLLECTION badge, not a TrustBox with the rating/count/review content at the decision point. The engine should distinguish Trustpilot widget TYPE (review-collection link vs rating TrustBox) and score review POSITIONING, not just "reviews exist".

**5. Schema/topic-vs-goal mismatch is a killer AI-search finding.** Heatzen's ld+json declares it an Article about "boiler grants" (keyword "boiler grants"), there's no `<h1>`, and no LocalBusiness/AggregateRating/Service/FAQ schema despite having an FAQ section + 305 reviews. Engine should compare declared schema topic against the client's TARGET service (solar) and flag the gap, plus check for missing AggregateRating when reviews exist.

**6. Recurring diagnosis pattern to encode: "two businesses through one front door".** A trusted brand whose shop window (homepage) points at a low-value / ending funnel (ECO4 closes Dec 2026) while the profitable, self-funded work + the trust equity + the good tools are pointed the wrong way or buried. Fix = move the right shop window (calculator + reviews + packages) to the front door, not "add more content". (Same ECO4-ending risk seen in the Arktek audit.)

**7. Check sister-site / ownership.** Footer + schema revealed Heatzen is a trading style of Proximus Solutions Ltd, and Proximus is a solar-led sister site with no review equity. Two sites = merge-under-the-trusted-brand case. Engine should read the footer/schema for owning-company + sameAs socials.

**9. Check the OG / Twitter share tags (social-sharing tech).** BOTH Heatzen and Proximus have `twitter:card=summary_large_image` but ZERO `og:image` and ZERO `twitter:image`, so any share (WhatsApp/FB/LinkedIn/iMessage) renders a blank/broken card and the platform scrapes a fallback (Heatzen's schema primaryImageOfPage was an EPC energy-band chart, a terrible share preview). Engine should parse og:image/twitter:image presence + card type, and flag OG title/description that name the wrong service (Heatzen's OG says "free boiler grants"). Cheap, high-signal finding.

**10. Every audit now OPENS with a benchmarked "cost of the gap" exec summary (Serafim/boss request, 8 Jul).** Reports are a lot to read, so before the detail put a top block naming the biggest losses + a £ revenue-at-risk figure, with 4 stat tiles (measured %s + the £), 3 losses on the left, plan-of-action on the right. Cite real benchmarks: BrightLocal Local Consumer Review Survey 2026 (97% read reviews / 68% won't use <4 stars), WebFX/LocaliQ home-services conversion (2-4% solar), MCS/market solar job value £7.5k-£14k.

**CRITICAL framing lesson (Charlotte, 8 Jul), the £ number MUST tie to cause and not overclaim:**
- Do NOT assert "you're losing £X" free-floating, tie it to the specific site flaw (no solar path on the homepage).
- The website's controllable output is the ENQUIRY, not the closed job, closing a survey is THEIR sales at THEIR close rate, which we don't control. Attributing full job revenue to a website fix overclaims.
- BUT the strongest, most defensible framing (Charlotte's): every lead checks the site before committing, ESPECIALLY after a survey (backed by the 97% stat), so a solar-first, review-led site works on TWO levers, more enquiries in AND a higher CLOSE RATE on the surveys they already run. Model the £ as close-rate uplift applied to their OWN existing survey pipeline (a real number) + enquiry uplift, not as new-traffic guesswork. Label "Modelled on your pipeline" and show the working ("How we get there: review behaviour measured, enquiry rate + job value benchmarked, close-rate lift on your pipeline; refined with your real survey volume + close rate").
- Don't over-caveat in the box (Charlotte cut a wordy GA4 line); keep the tile punchy, put the sourced working in the footnote.
- Name sources but note BrightLocal etc. are research firms, not competitors (Charlotte checked).

**FINAL cost-box spec (after a long back-and-forth with Charlotte, 8 Jul, this is the signed-off shape):** a **visible worked example**, every input shown as a segment, no hidden maths, no promise, no "you replace" language (it is a static page, not interactive). The landed model:
- Lever = **close rate on their EXISTING survey pipeline**, not new traffic. Mechanism (backed by the 97% stat): every lead checks the site before signing, especially AFTER a survey; a grant-funnel site with hidden reviews plants doubt, a solar-first review-led site reassures.
- Use **MARGIN, not revenue**. Revenue (£7.5k-£14k install) overstates the gain; margin = a conservative 25-30% of that (~£2k-£4k/job; installer gross margins run 25-35%, SurgePV/industry).
- The sum shown: `[+2 jobs a month] × [£2k-£4k margin a job] × [12 months] = [£48k-£96k a year]`, framed "say you run ~30 surveys a month, close just 2 more." Conservative, honest, still a strong ROI vs a ~£1.5k build.
- Explain in plain words (not jargon): drop "+3 pts / 3 in 100"; say "close 2 more of your surveys a month." Note the mechanism, label "Conservative illustration", cite sources in the footnote.
- Charlotte's hard rules: can't assert money with no input behind it (it read as made up), can't overclaim (margin not revenue, close is THEIR sales), but don't undersell the site's value either.

**DESIGN + QUALITY BAR the CREW report generator must hit** (this audit is the reference; source `meta-access/outputs/sitescore-heatzen/report.src.html`, built via `build-report.mjs` -> inlines gauges + base64 imgs + InstallrHub SVG; `build-gated.mjs` wraps the sessionStorage pw gate; deploy = own `sitescore/<slug>` branch in installrhub-static, PR, never self-merge):
- **InstallrHub house style** (matches Arktek/HQ): light paper body, dark nav + "AUDITED FOR" co-brand band (InstallrHub SVG + client logos on white chips), dark hero, `.scores` meter rows (green/gold/red by band), keep/fix panels, `.find` findings (screenshot + red callout + green "The move"), dark `.road` roadmap. Client accent = their brand colour.
- **Structure:** co-brand -> hero (headline + sub + site chips) -> **scores front and centre** (per-site score cards) -> cost-of-gap exec summary -> tabs per site (gauge + band + dual sub-scores + verdict + 8-dim scorecard + keep + findings + root-cause ceiling) -> verdict/merge -> roadmap.
- **Multi-site audits:** score each site, then a "verdict" tab making the consolidation case (Heatzen trust + Proximus solar -> one site). Bring EVERY site to equal depth (don't half-length the secondary one).
- **Live safety check:** flag Google Safe Browsing "Dangerous" warnings (Proximus was flagged) as an urgent red alert + Search Console reinstatement rec.
- Charlotte's design feedback pattern: match the existing house style (don't invent a new one), balanced padding, co-branding + client logo at top, scores prominent, numbers must be causally tied and sourced.

**8. De-biased scoring held up:** score design/build/copy independently; a clean, well-built solar sub-page scored design 64 honestly while the homepage's conversion-for-solar scored ~30. Don't let a tidy build flatter a misaligned funnel. Voice = B2B consultative (per METHOD.md), lead with opportunity then evidence then fix, honest but never mean.

Applies to every pillar. This whole file = the spec for building today's hand-built audit intelligence into the CREW auto-engine (next session's job). See [[project_crew_next_session_pickup]].
