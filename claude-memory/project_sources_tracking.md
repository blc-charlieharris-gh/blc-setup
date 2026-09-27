---
name: project-sources-tracking
description: "B2B Sources tracking: site + hub + n8n all LIVE; only the edge fn patch remains"
metadata: 
  node_type: memory
  type: project
  originSessionId: 5cf7e5df-a104-4414-952e-381d8eec04a6
  modified: 2026-08-10T15:11:20.375Z
---

InstallrHub B2B lead attribution feeding **Sources** on the hub (`marketing-agent`,
`/sources`, INSTALLRHUB nav section). NOT the app.

**Three fields, one story** (live in site-installrhub, verified in prod 2026-08-05):
- `ih_channel` = how they reached the site. First-touch, frozen for the session.
- `ih_landing` = which page they entered on.
- `ih_place` = which CTA converted them. Hardcoded per link, last click wins.

**ORDERING MATTERS: attribution lives in `js/track.js`, loaded in `<head>`, NOT
`main.js`.** The homepage/`/contact` Fillout iframes use
`data-fillout-inherit-parameters`, which reads the parent URL when the embed
initialises partway down the body. `main.js` loads at the END of the document, so
anything written there lands after Fillout has already read the URL. Two homepage
test leads proved it: `utm_*` populated, every `ih_*` blank. Never move this back.

**CRITICAL RULES:**
- `fbclid` is NOT proof of paid traffic (Facebook appends it to organic links too).
- Our Meta ads carry NO `utm_source`; `utm_medium` is the AD placement
  (`facebook_feed`). `isMetaAdPlacement()` catches this, else every ad reads organic.
- `utm_campaign` is OVERLOADED: adset id from landing pages, campaign id from Meta
  instant forms. Always try BOTH joins; assuming adset drops 78% of rows.
- Two different things are called "placement": `utm_medium` = ad placement,
  `ih_place` = site placement.

**DONE (chain complete end to end, verified in prod 2026-08-07):** site tracking, hub
Sources page + link builder (`#493`, `#497`), all four n8n mappings, GHL custom fields.
`ghl-installr-lead-webhook` **v11** landed 2026-08-05 (Serafim kept the WHOLE body as
`raw` rather than applying our whitelist patch, better call): rows went 8 `raw` keys
-> 80+. `short_links` migration is APPLIED, so the /sources Links tab no longer errors.
The old `SERAFIM-edge-fn-patch.md` is now superseded, do not hand it over again.

**2026-08-10 AUDIT, last 7 leads. Charlotte was right that it is not fully reporting.**
Counts over every post-v11 row: channel 3/7, landing 1/7, **referrer 0/7, fbclid 0/7**.

**ROOT CAUSE (FIXED 2026-08-10, branch `fix/track-forward-referrer` in site-installrhub):**
`js/track.js` computed `ih_referrer` on arrival, then kept it in `DERIVED` (off outbound links)
while `syncUrl` wrote only `['ih_channel','ih_landing','ih_place']` into the page URL. Fillout
embeds read the parent URL and nothing else, so the referring site never reached any form. The
old justification, "recoverable from ih_channel", is wrong: ih_channel collapses arrival to one
word, so `direct` erases the origin. Fix = `ih_referrer` into KEEP + into the syncUrl list.
The GHL custom field already exists (the key is in `raw`, always empty), so likely no GHL work,
but UNVERIFIED until a real site lead lands.

**CORRECTION, do not repeat:** `fbclid` is NOT broken and was never dropped. It has always been
in `KEEP`, so it persists and reaches the forms. It reads 0/7 only because no lead in that
sample was a site visitor carrying one (2 were Meta instant forms that never touch the site, 4
were funnel-form leads losing everything, 1 was genuinely direct). Likewise the 0/7 on referrer
does NOT by itself prove the bug: the only site-form lead was direct, so empty was correct
there. The CODE proves it, the sample does not.

**REAL KEY NAMES in `raw`, our docs had these wrong:** `ih_landing_page` (NOT `ih_landing`),
`ih_referrer`, `installrhub_url`, `fbclid`, `contactSource`/`contact_source`, and UTMs are
TITLE CASE with spaces (`UTM Medium`, `UTM Campaign`, `UTM Content`) except `utm_source` which
is lowercase. Query the wrong name and every row reads null. `ih_place` does not exist in the
DB; the populated one is `ih_placement`.

**Forecast leads still land with ZERO attribution** (3 of the last 7: Passionatecare1Ltd,
Ben Thorp, Cube) but DO carry `contactSource=installrhub-forecast`, so they are at least
identifiable. Confirms [[project_forecast_utm_attribution_gap]] is still open on 08-10.
Instant-form leads are fine: channel=paid-social, utm_source=meta, `UTM Medium`=ADSET id,
`UTM Content`=ad id, `UTM Campaign`=campaign NAME ("FB Instant Form - DTO"), not an id.

**PROOF ROW:** `sales_lead_intake_events` 2026-08-05 15:07 (Meta instant form) carries
`ih_channel=paid-social`, `ih_placement=meta-instant-form`, `utm_source=meta`. That is
the only fully-attributed real lead so far, because B2B volume is tiny: 14 rows in 14
days and NOTHING since 2026-08-05 19:03. Low N is a volume story, not a tracking bug.
The 19:03 forecast lead has the `ih_*` keys present but EMPTY (direct/organic, or the
forecast custom-field gap), so watch it, don't yet call it broken.

**REMAINING (not blocking):** v11 repo drift, live only on Supabase; the function source
is NOT in marketing-agent (`supabase/functions/` has only crew-audit, funnel-beacon,
site-feedback, site-public), the deployed source is staged at
`.claude/docs/deployed-edge-fns/ghl-installr-lead-webhook.v11.index.ts`. Mirroring it
into the app repo is Serafim's. Tripwire: `min` count of `raw` keys per day (8 =
reverted, 80+ = fine). Plus test-row cleanup.

**2026-08-11, EMAIL CHANNEL WAS STRUCTURALLY BROKEN (fixed).** `deriveChannel` matched email on an
exact `utm_medium === 'email'` while every nurture link tagged `email-automation`, so every nurture
click was filed as `referral` and the Email row could only ever read zero. Fixed at both ends: the
classifier now matches the `email` prefix (live), and a migration retags the sequences at source
(`20260811140000`, pending Serafim's apply). Detail in [[feedback_email_channel_exact_match]].

Same day: the GHL booking widget started receiving attribution at all, plus contact prefill on all
three funnels. See [[project_booking_widget_attribution]]. And the forecast attribution gap is
CLOSED, not open: site-installrhub #54 merged 08-10 16:26 and the last blank forecast lead predates
it by ~2.5 hours. Unproven only because no forecast lead has landed since.

**NEXT BUILD:** replace the two Fillout forms with in-house forms posting to
`/api/lead` (kills the iframe race permanently; pattern in `forecast/index.html`),
then pretty links (`short_links` table + `/go/:slug`).

**Do NOT re-chase:** the nurture stop-on-stage exit works (20-min cron, verified
`stage_reached:lost`). CPL is £110 everywhere. Outbound is ~97% of pipeline and
never touches the web, so Sources merges hand-entered `sales_channel_stats`.

Related: [[project_forecast_utm_attribution_gap]], [[reference_nurture_engine]],
[[reference_greentide_utm_attribution]].
