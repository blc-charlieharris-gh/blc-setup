---
name: project_greentide_lead_tracking
description: "How Green Tide landing-page Meta lead tracking works and why Meta under-counts vs Fillout (consent-gated pixel, not a bug)"
metadata: 
  node_type: memory
  type: project
  originSessionId: 0c5c6db7-669d-4b60-b1b5-15e1ba635b38
---

Green Tide landing-page campaigns (heat-pump + solar, `site-greentide/site/`) track Meta leads via a **first-party** Meta Pixel `2551121045236896` ("Green Tide - formerly Leicester Solar"), NOT via a pixel inside the Fillout iframe. The pixel is **consent-gated** in `js/main.js` (`cookieConsent` IIFE): it only loads after the visitor clicks Accept on the cookie banner, then fires PageView; the `/:product/eligible` thank-you pages fire `fbq('track','Lead')`.

**Why Meta under-reports vs Fillout (e.g. 6 in Meta vs 13 in Fillout):** NOT a broken pixel. Two stacked, largely-correct causes: (1) consent gating, decliners legally must not be pixel-tracked; (2) non-paid traffic reaching the form with no `fbclid`. So Meta always under-counts. Treat **Fillout/CRM as the true lead count**, Meta as optimiser signal. Same family as [[project_db_meta_underreporting_attribution]] and [[reference_reconcile_bar_semantics]].

**Custom conversions (2026-07-07):** split the old shared `NEW-LandingPageConversion` (rule `URL contains "eligible"`, which wrongly counted `/not-eligible` DQ pages because "not-eligible" contains "eligible") into two, each `PageView` + URL `i_contains`:
- HEAT PUMP LEAD (id 1735283021225130) = `/heat-pump/eligible`
- SOLAR LEAD (id 1336079032061021) = `/solar/eligible`
Leading slash excludes the `not-eligible` pages. Active landing adsets repointed accordingly. Old shared CC 36545640008384423 left un-archived but unused. Legacy CC `976031048922279` (apply.home-upgrades.co/heat-pump-thank-you) still referenced by PAUSED heat-pump adsets, repoint before re-enabling.

**Fixes shipped this session (deployed to greentideenergy.com):** cross-subdomain consent now stored in a `.greentideenergy.com` cookie (was per-origin localStorage, so a user who accepted on one subdomain and converted on another never fired Lead); `/apply-9k` 404 redirected to `/heat-pump`; `solar-v2/` retired (pages deleted, `/solar-v2/*` redirects to `/solar/*`). Parked bigger wins: cookie accept-rate UX + server-side CAPI. Deploy: `vercel deploy --prod --yes --scope blc-promotions` from `site/` (no Serafim sign-off for GT).

**2026-07-30 re-confirmed + spec written.** Charlotte: solar "Meta tracked 4, Fillout tracked 7" (HP 7/8). Verified NOT solar-specific: `/solar/eligible` + `/heat-pump/eligible` wired identically, solar Fillout redirect to `apply.greentideenergy.com/solar/eligible` confirmed correct by Charlotte. Dominant leak = people **submit the form without clicking Accept** on the cookie banner (form works regardless), so pixel never loads → no Lead. 4/7 vs 7/8 is small-sample noise on top of that structural gap, not a bug. CAPI agreed as the real fix, parked ("sort eventually"). Full handoff spec written to `site-greentide/docs/meta-capi-lead-spec.md` (fbclid→fbc, hashed em/ph, event_id dedup, consent-field caveat, lives in Serafim's n8n); logged in `docs/known-issues.md`. CLAUDE.md "consent per-origin localStorage" line is STALE, code already uses the shared cookie. Distinct from the parked `gt_exp` variant-attribution gap [[project_greentide_split_testing_gap]].
