---
name: project_dashboard_leads_card_is_meta
description: "RESOLVED 2026-07-22: the Performance 'Leads' card now reads our CRM count (not Meta's 163); it only falls back to Meta with an explicit 'Meta's count' caption for lead-only clients or no-CRM-access. Kept for the 163-vs-169 diagnosis history."
metadata: 
  node_type: memory
  type: project
  originSessionId: aa2b40e6-5935-4d29-9645-f66f9d2bc770
---

**Proven 2026-07-20 by exact match.** Charlotte reported the dashboard showing **163** Green Tide leads for 12-18 Jul while Serafim's app.installrhub raw leads read **169**. Every other figure on the screen agreed, which was the clue: it is not a counting bug, it is two different quantities.

`sum(ads_insights_daily.conversions)` for Green Tide over 12-18 Jul = **exactly 163**. Raw `lead_intake_events` for the same window = 171 (UTC) / 170 (Europe/London), deduped by `ghl_contact_id` = 171 (no dupes, no null contact ids).

**So the card labelled "Leads" is Meta's own conversion count.** `usePeriodActivityTotals.js:24-36` reads `ads_insights_daily.conversions`, scoped by `resolveScopeIds` (`clientScope.js:16`, `name ~ /^greentide/i`). It never touches `lead_intake_events`. Meta under-counts by design (consent decliners, non-paid traffic, cross-device), so it will always sit below our DB count. See [[project_greentide_lead_tracking]].

This contradicted the settled [[reference_lead_counting_model]], where campaign/tech/destination views count OUR leads.

**RESOLVED 2026-07-22 (decision = both).** `usePeriodActivityTotals.js` was rewritten to count our CRM leads (header now: "LEADS ARE OUR CRM COUNT, NOT META'S") and returns a `leadsBasis`. The presentational `BlendedCards.jsx` shows the CRM count with no caveat by default (`basis='db'`), and only falls back to Meta's number WITH an explicit "Meta's count" note in two cases: lead-only client (no CRM step) or `meta_no_access` (viewer lacks admin access to CRM leads). So the card was both repointed to CRM and honestly relabelled on fallback. The only way to still see 163 is viewing without admin access, and the card now says so. No open task.

Serafim's 169 vs raw 171 is a separate, much smaller 2-lead delta, most likely his own window/timezone boundary. Not chased.

Other paths that legitimately drop leads (from a full code trace, all real): `ad_performance_with_leads` filters `utm_content ~ '^[0-9]{15,20}$'` AND is driven `from ads_insights_daily`, so leads on ad-days with no Meta insights row vanish (its own header admits "~half"); `destination_funnel` inner-joins `ads_ads` on utm_content and dedups `distinct on (ghl_contact_id)`.
