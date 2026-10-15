---
name: project_ih_kpis_journey_page
description: "InstallrHub KPIs page (/ih-kpis) rebuilt 10-15 - one row per person by first entry, funnel cards with rates, source tabs, Awareness Feeds, /kpis share link"
metadata:
  node_type: memory
  type: project
  originSessionId: 862a8d37-73ba-4964-9ede-bf32cd0b4fc6
  modified: 2026-10-15T15:57:21.848Z
---

The InstallrHub KPIs page (/ih-kpis, marketing-agent) was rebuilt on 2026-10-15 in PRs #1955, #1959 and #1970, all merged.

- **The old bug:** sign-ups who booked a call were turned into sales leads. For 8-14 Oct it showed 50 sales leads and 92% booking triage, when the real figures were about 21 leads and about half booking.
- **The rule now (summariseB2bJourney):** each person stays in their first-entry row (sales lead / sign-up / no form) and source (ad campaign, social, organic, email/SMS, outbound, none). summariseB2bFunnel is unchanged for Goals.
- **Funnel cards per kind:** same-people rates. Shown rates leave out calls still to come or not logged.
- **Source tabs:** spend only shows on All and Ads.
- **ads_campaigns.feeds_campaign_ids:** migration 20261015135700, run by Charlotte. Set via "Feeds" on Awareness campaigns on the client card. Unset means the spend feeds every Leads campaign that spent, split by new people.
- **Share link:** /kpis?from=&to=&source=&view= opens the live page and needs a Hub login with InstallrHub. A frozen no-login snapshot for the CEO has been offered but not built.

- **10-15 later, #1996 merged:** the Overview is now "pick your view" (lib/kpiViews buildView). The controls are Rows (source / campaign or channel / kind), Over time (all / week / month, nested under each row), Count (people who came in = cohort, or what happened in the dates = activity) and Show (everyone / sales / sign-ups). There's a funnel strip on top. The share link carries every setting. A frozen CEO report is still not built.

**Why:** Charlotte needs to trust the IH funnel numbers (lead, triage, demo, close).

**How to apply:** change the rules in lib/b2bAppointments (journey section). Cross-check numbers against SQL on sales_appointments plus intake first entries. Related: [[reference_webinar_booking_stats_sql]]
