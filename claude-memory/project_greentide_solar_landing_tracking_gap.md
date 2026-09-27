---
name: project_greentide_solar_landing_tracking_gap
description: "2026-07-17: the utm_content gap is EXACTLY the solar Fillout form (14% vs 94-100% everywhere else); ads/redirect/pages all proven fine. Charlotte re-added the field, unverified. Earlier: PII-in-URL blocked Meta conversions (fixed), rogue HP pixel (removed)"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1a8ed7c6-2687-4a83-9559-79fb3caafd7b
---

# Green Tide solar tracking: the 2026-07-16 investigation

**Read this before touching solar tracking. Two real bugs were found and fixed. One thing is still open. A LOT was ruled out, do not re-chase it.**

## ✅ ROOT CAUSE #1 (Charlotte found it): PII in the eligible URL blocked every Meta conversion

The solar Fillout form's after-submit redirect passed the lead's details into the URL:
`https://apply.greentideenergy.com/solar/eligible?name=…&number=%2B441888777666&email=…%40…&address=…&postcode=…`

**Meta detects potential personal data (email / phone) in a page URL and DISCARDS the event.** So the `SOLAR LEAD` custom conversion (`PageView` + URL contains `/solar/eligible`) could **never** fire, regardless of the rule being correct. Heat pump's redirect did not carry PII, which is the whole asymmetry.

**This is why "the pixel fires but Meta reports nothing" was true simultaneously.** A live Puppeteer test proves the browser DOES send the event (`id=2551121045236896 ev=PageView dl=…/solar/eligible`, plus a `Lead` event). Meta receives it and throws it away. Testing the browser side can never reveal this: you must think about what Meta does on receipt.

**FIXED 2026-07-16:** Charlotte removed the PII params from the solar Fillout redirect. Watch for `SOLAR LEAD` conversions appearing and the solar landing CPL collapsing from a fake ~£300 toward the real ~£33. (`/solar/not-eligible` does NOT carry PII, confirmed, nothing to do there.)

## ✅ ROOT CAUSE #2: a rogue legacy pixel inside the heat pump Fillout form

Two pixels exist on the account, BOTH live:
- **2551121045236896** "Green Tide - formerly Leicester Solar" (Apr 2025) = the REAL one. Fired by `main.js`, consent-gated. All current CCs + both adsets' `promoted_object` use it.
- **2087407221715362** "Green Tide Energy" (Nov 2024) = LEGACY. Was baked into the **heat pump Fillout form `cVaNxEPM6uus`**, firing `PageView` from `embed.fillout.com` for EVERY visitor **pre-consent**. The ads don't optimise on it.

That inflated heat pump's landing_page_view to 67% (it counted everyone) while solar's 11% only counted people who accepted cookies. **The 67% vs 11% gap was an artefact, not a solar failure.** **FIXED:** Charlotte removed it. Expect heat pump's LPV to fall toward solar's. That drop is correct, not a regression.

Legacy clutter still on 2087 (dead URLs, cosmetic only): `Landing Page`, `Green Tide New Lead`, `Might Qualify`, `Form Submission`, `Green Tide Lead`. Also `NEW-LandingPageConversion` sits on 2551 and overlaps both techs. Naming is misleading: the LIVE pixel is the one called "formerly Leicester Solar".

## 🔬 2026-07-17: NARROWED TO ONE THING, the solar Fillout form itself

Attribution coverage over 14d makes the fingerprint exact. It is **not** "solar leads arrive untagged":

| Surface | Leads | Attributable |
|---|---|---|
| Solar Instant Form | 165 | **100%** |
| ASHP Instant Form | 100 | **100%** |
| ASHP Fillout (landing) | 50 | **94%** |
| **Solar Fillout (landing)** | **14** | **14%** |

Solar's instant form is perfect and heat pump's Fillout is fine. **Only the solar Fillout form `j8PZnxxfcWus` loses `utm_content`** (heat pump's is `cVaNxEPM6uus`).

Additionally proven fine on 2026-07-17, from live checks:
- **Ads tagged**: read `url_tags` straight off the creative via the Meta API for every active solar landing ad. All correct.
- **Redirect preserves the query**: `http://apply.greentideenergy.com/solar?utm_content=X` returns 308 then 200, params intact.
- **Pages identical**: `apply.greentideenergy.com/solar` and `greentideenergy.com/solar` are byte-identical, both carry the beacon and `data-fillout-inherit-parameters`. Only the form ID differs.
- **Only ONE campaign drives the solar landing page** (Meta API): Instant Form and Back Up PPL have no website destination at all. This is what makes the untagged-lead attribution rule sound, see [[reference_lead_counting_model]].

`data-fillout-inherit-parameters` only forwards params into fields the form DECLARES. If `utm_content` is not declared in the solar form's builder config, Fillout silently drops it. **Last standing candidate, by elimination rather than direct observation** (the builder is not inspectable from code).

**STATUS: Charlotte deleted and re-added `utm_content` on the solar form 2026-07-17, saying nothing looked wrong with it. UNVERIFIED**, because zero solar Fillout leads landed that day (spend was £5.74 vs a normal ~£40, so no traffic to test with). Check:
```sql
select occurred_at, utm_content from lead_intake_events
where technology='Solar' and contact_source='Greentide Fillout'
order by occurred_at desc limit 5;
```
If it worked, coverage climbs off 14% on its own and the red CoverageBadge clears itself.

**The cost while broken:** solar landing really runs at ~£41 CPL (14 leads on £578/14d); the dashboard read £288.94 and shouted STALLED because it divided by the 2 tagged leads. The lead-basis migration fixes the CAMPAIGN number but canNOT fix creative-level testing on solar landing, which stays unusable at 14% coverage until the form works.

## ❌ HISTORIC framing: utm_content 22% (solar) vs 92% (heat pump)

Superseded by the coverage table above. Not consent, not the pixel, not PII. Separate path: URL → Fillout iframe → Fillout → GHL → webhook.

**The contradiction nobody has resolved:** the Fillout iframe **provably receives** `utm_content` (iframe src = `embed.fillout.com/t/j8PZnxxfcWus?utm_content=…&fbclid=…&utm_campaign=…`), the webhook is a **pure pass-through** (`pick(body,["utm_content"])`, no overwriting), and **50 heat pump leads in 14d trace back via utm_content to the HP landing ads** so tagging demonstrably works in production. Yet most solar leads arrive with nothing. ASHP has held 77-100% weekly for 12 weeks and is STILL 100%; solar has been ~0-23% throughout. Not a regression, not recent.

**Next step: measure, don't theorise.** Add query-string logging to `funnel-beacon.js` (see below) and read what real visitors actually arrive with.

## ❌ STILL OPEN: the split test can't name a winner
`funnel_events` shows landing variant a/b fine (solar 22/14), but **no qualify/dq visitor_id matches any landing visitor_id**, so conversions can't be attributed to a variant. The beacon DOES set a 365-day `gt_vid` cookie on `.greentideenergy.com` and the code looks correct, so WHY it isn't persisting is undiagnosed. Suspect an iframe/partitioned-cookie context. Diagnose before changing (it drives the live A/B split).

## RULED OUT (verified 2026-07-16, do NOT re-chase)
- **Page weight / the Fillout PNGs.** Images removed; both pages now measure **338 KB / 21 requests** (solar 2.7s, HP 2.0s) on mobile Puppeteer. LPV did not move. The old "1039KB vs 461KB" theory is DEAD.
- **"Organic traffic".** It's a new ads-only page. Wrong.
- **Consent rate.** Cannot explain it: `fbclid` needs no consent, yet 6/6 leads had `fbclid=""`.
- **Fillout form config.** Charlotte confirmed URL parameters match exactly (utm_medium/utm_campaign/utm_content/fbclid/gt_exp on both; solar adds address+postcode).
- **The ads.** Both techs identically tagged (`utm_medium={{placement}}&utm_campaign={{adset.id}}&utm_content={{ad.id}}`) on the creative, for every ad that actually spent. Destinations identical (`http://apply.greentideenergy.com/{solar,heat-pump}`). No ad has params baked into the URL.
- **Custom conversion rules.** Correct + symmetric, same pixel.
- **Placement.** Solar is bad on EVERY platform (facebook 20% vs HP 76%).
- **Pages/scripts/banner.** Byte-identical bar copy; same `main.js`/`experiments.js`/`funnel-beacon.js`; same cookie banner; `replaceState` preserves the query string; `http→https` 308 preserves params; `/apply-9k` 307 preserves params.
- **The webhook.** Pure pass-through.

## ⚠️ TESTING TRAP THAT COST HOURS
**Meta does NOT append url_tags to ad PREVIEW clicks** (documented). A preview click shows `fbclid` but no UTMs, which looks exactly like the bug and is completely normal. **Never diagnose tagging from a preview.** Use real production data (trace `utm_content` values back to `ads_ads.external_id`) or the beacon.

## Also found
`ads_ads.url_tags` is empty for EVERY ad in our DB because `meta-sync` requests `url_tags` at the AD level while Meta stores it on the **creative** (`creative{url_tags}`). So "are the ads tagged?" is unanswerable from the DB, ask the Graph API. Worth fixing in meta-sync's field list.

## Method note for next time
Five wrong theories were chased (organic → form config → page weight → consent → interest-selector). Charlotte was right at every step and was twice talked out of a correct instinct. **The lesson: the browser sending an event does not mean Meta accepts it.** When "everything is configured identically but the numbers differ", suspect what the receiving platform does with the data, not just what we send.

See [[reference_greentide_utm_attribution]], [[project_greentide_lead_tracking]], [[project_greentide_split_testing_gap]].
