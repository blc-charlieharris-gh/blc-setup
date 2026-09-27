---
name: project_client_landers
description: "Client landing-page engine (client-landers/) — tokenized GT-mirror ad funnel, deploys to <client>.homeenergyupgrades.co; HQ Group is v1 installer template"
metadata: 
  node_type: memory
  type: project
  originSessionId: 8bdca9c4-305c-441a-bcb3-a81bab198c50
---

New standalone product at `/Users/charlotteharris/Documents/BLC/client-landers/`. Generates a high-converting **ad landing funnel** (landing + heat-pump/eligible + not-eligible + terms/privacy/cookies + 404) mirroring the proven Green Tide `heat-pump` design, per client, deployed to `<subdomain>.homeenergyupgrades.co`.

**Distinct from** the `/sites` ClientSiteGenerator [[project_clientsitegenerator]] (crawl+AI full multi-page company sites, per-client Vercel projects) and from the bespoke `client-sites/` folder. Charlotte was explicit: keep these separate.

Architecture: template + per-client `config.json` + plain Node ESM generator `build.mjs`. No output build step (pure static). `template/`: `styles.css` (`:root` brand tokens `__BRAND_*__` injected by build), `main.js` (`__PIXEL_ID__`/`__APPLY_HOST__`/`__FILLOUT_FALLBACK_URL__` injected), `partials.mjs`, `render.mjs` (config-driven landing sections), `pages.mjs`, `legal.mjs`. Run `node build.mjs <slug>` or `--all` → `dist/<subdomain>/`; also emits `dist/vercel.json` with a host-rewrite per client. Preview: `cd dist/<subdomain> && python3 -m http.server` (absolute /css /images paths need the client folder as root).

`config.identity.businessModel`: **installer** (HQ Group: first-party "our engineers", own accreditations, no lead-gen disclaimers) vs **lead-gen** (GT model). Compliance carried from GT: Meta Pixel consent-gated in main.js (required per-client pixelId), cookie banner, funnel noindex (meta + X-Robots-Tag), Fillout embed + per-client fallback.

**HQ Group = v1 test client AND the reusable installer template.** Real installer, heat-pump. Owns `homeenergyupgrades.co` but NOT yet in Vercel. Phase 1 (built 2026-07-03) done: full site generates + verified white-label + live local preview. Still PLACEHOLDER in `clients/hq-group/config.json` (Charlotte owes real values before live): Meta Pixel id, Fillout form id (+ set its redirects to /heat-pump/eligible + /heat-pump/not-eligible), company number, registered office, support email, and real logo/favicon/accreditation SVGs + testimonials in `clients/hq-group/assets/`. No ICO field (Charlotte won't have it per client).

Phase 2 = deploy (Charlotte adds domain+wildcard to a new blc-promotions Vercel project, then `vercel deploy --prod` the dist tree). Phase 3 fast-follow = a marketing-agent "Landing Pages" UI button (distinct from /sites) that writes a config + triggers generate/deploy.

**Client 2 = Arktek (SOLAR), added 2026-07-10.** `clients/arktek/`, `arktek.homeenergyupgrades.co`, businessModel=installer, `tech: "solar"` → routes `/solar/eligible|not-eligible`. Real legal details in config (Arktek Group Limited, Co. 09877542, VAT 227 9163 91, Unit JC9 Jupiter Centre Sunderland SR5 2TA, info@arktek.co.uk). Self-funded-first positioning, ECO4/LA Flex as the secondary funding lane.

**GOTCHA FIXED (2026-07-10): `template/legal.mjs` used to HARDCODE "MCS-certified heat pump installer" + Boiler Upgrade Scheme** into terms + privacy, tokenizing only the brand name. It was invisible while HQ Group (heat-pump, MCS) was the only client; the first solar client silently generated legally false claims. Now config-driven via `legal.serviceDescription` (predicate after brand name), `legal.techNoun`, and `legal.grant` ({tocLabel,title,termsBody,privacyPurpose,privacyRecipient} or null), with **dynamic section numbering** so omitting the grant section leaves no hole. HQ output unchanged. **Never hardcode tech/accreditation/grant in the template.**

**Arktek honesty constraints (do not break):** Arktek is Gas Safe registered (real) but has **NO confirmed MCS** — and MCS matters for solar (SEG export payments). `proof.trustLogos` is deliberately EMPTY (accredStrip renders nothing) and no MCS is claimed anywhere. `showcase` omitted because the shared `template/assets` photography is ALL heat-pump (hp-*.jpg, old-boiler); needs real Arktek solar install photos. Testimonials are clearly-marked PLACEHOLDERs. `benefits.compare` figures are illustrative and need confirming. Before live also: Meta Pixel id, Fillout id (+ redirects to `/solar/eligible` + `/solar/not-eligible`), real logo/favicon SVGs (current ones are brand-accurate red-"A" placeholders I authored).
