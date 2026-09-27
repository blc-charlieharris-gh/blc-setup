---
name: project_booking_widget_attribution
description: "GHL booking widget on the InstallrHub site: how attribution and contact prefill reach it, and the ih_place vs ih_placement name split that must stay"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1d7c3945-3ca4-4bb5-9649-3f4c576a2a03
  modified: 2026-08-11T15:54:26.315Z
---

Built 2026-08-11 (site-installrhub #55, #56, #57, #58). The GHL calendar widget
(`link.blc-promotions.com/widget/booking/yEw664fX6up5dLb7TL75`) is embedded on
**three** pages: `/book-a-demo`, `/breakdown/resources`, `/forecast/reveal`.

**It used to receive NOTHING.** `decorate()` in `js/track.js` skips cross-origin
URLs by design and the widget is an iframe, so a demo booked straight off a
nurture email reached the CRM with no source at all. Same hole the Fillout embeds
had, different embed.

**Now:** `decorateWidgetFrames()` in `js/track.js` puts the tracking bag AND the
contact fields on the widget URL. Two embed shapes are handled: `src=` (loads on
parse) is reassigned; `data-src=` (lazy-loaded on click by `forecast.js`) is
rewritten in place so it stays lazy.

**Contact prefill.** Every booking page is the SECOND page of a funnel: homepage
form to `/book-a-demo`, breakdown modal to `/breakdown/resources`, forecast to
`/forecast/reveal`. All three call `window.ihTrack.rememberLead(...)` on submit,
writing one `ih_lead` sessionStorage bag that `track.js` reads when building the
widget URL. **Add a fourth funnel = one `rememberLead` call**, do not copy the
logic. Takes `first`/`last` OR a single `name`.

**THE NAME SPLIT, do not "tidy" it.** GHL's booking form fields are
`contact.ih_placement` and `contact.ih_landing_page`; the site writes `ih_place`
and `ih_landing`. Neither side can be renamed: GHL's names are load-bearing in
n8n and every stored row, the site's are in `SITE_PLACEMENTS`, the link builder
and every tagged nurture link. So the widget URL carries **both spellings**, via
`WIDGET_ALIASES`, on the iframe only. See [[feedback_email_channel_exact_match]].

**Getting GHL's real field keys** (do this rather than guessing at param names):
`curl https://backend.leadconnectorhq.com/forms/data/mMAaI5PjG8Nhm6QnisZq`. That
is how the mismatch surfaced. `main_service` and `installs_per_month` are free
TEXT, not dropdowns, so each form sends its own human wording.

**Proven end to end** against production with Puppeteer (available in
`site-greentide/post-booking/node_modules`): an ad click carries
`utm_medium=facebook_feed`, `utm_campaign=<adset id>`, `utm_content=<ad id>` and
`ih_channel=paid-social` all the way to the calendar, on a second page whose own
URL carries nothing. Check the iframe's **loaded frame URL**, not just its `src`
attribute, or you only prove what you set.

Related: [[project_sources_tracking]], [[feedback_spa_stale_bundle_vs_deploy]]
(a "not working" report right after a merge is usually the old bundle: curl the
live file before debugging).
