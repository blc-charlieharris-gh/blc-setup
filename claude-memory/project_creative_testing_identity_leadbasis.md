---
name: project_creative_testing_identity_leadbasis
description: "Creative Testing measures tagged ads only (never ad names / thumbnail keys); Leads = Meta conversions on Testing + Performance, funnel = CRM"
metadata: 
  node_type: memory
  type: project
  originSessionId: 4f357ee0-cdae-4ae4-ac86-5e81651d1304
---

Fixed 2026-06-30 (marketing-agent, branch `fix/testing-performance-accuracy`), after Charlotte
spotted a £121 "ghost" row duplicated across two test cards.

**Creative Testing identity (decided + shipped):** a test measures ONLY the ads explicitly tagged to
it (`creative_test_ads`), keyed by the stable Meta `ad_external_id`. It must NOT pool by thumbnail
`visualKey` (the asset id in the t15 CDN path COLLIDES for video — distinct creatives like
video1/Plain oil/9k2/Winner3 shared asset `721322838`) nor by the `creative_merges` mergeMap (that
is the By-creative blend, a different surface). **NEVER use ad names** — operators copy ads and never
rename them, so names are meaningless. To capture a forced-spend duplicate, the operator tags that ad
to the test (or starts a new one); no auto look-alike detection. `useCreativeTestData` was rewritten
to filter the per-(campaign, ad) RPC rows to the tagged ad ids. By-creative (Performance) KEEPS the
visual-key blend on purpose, that is where "combined then per-campaign" is wanted.

**Lead basis (decided + shipped):** the "Leads" number = Meta `conversions` on BOTH Creative Testing
and the Performance per-ad table (matches Ads Manager + the rest of the Dashboard, e.g.
`campaign_windowed_totals` note `d3d21b21`). The CRM `leads_generated` bridge under-counts ~40-60% on
landing/instant-form (e.g. ad read 7 when Meta showed 8; a test read £60 CPL when Meta CPL was ~£24).
Funnel columns (booked / lost / chargeable / cancellations) STAY on the CRM bridge — Meta can't know
those. CPL = spend ÷ conversions; cost-per-booked stays CRM. Frontend falls back to the CRM count
until the two Tier-2 RPCs add a `conversions` column (`campaign_creative_cpl` v3 +
`ad_windowed_totals` v2 — Serafim apply).

**Performance paused-ad rule:** the per-ad table now shows paused ads that had in-window spend
(greyed) so leaf rows reconcile to the campaign header total — a paused ad's spend can't silently
vanish. See [[feedback_meta_lead_counting]], [[reference_greentide_utm_attribution]],
[[project_marketing_bigbuild_prs]].
