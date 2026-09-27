---
name: feedback-performance-reconciliation-gotchas
description: "Five distinct reasons two \"leads\" or \"booked\" numbers for the same client/window can legitimately disagree, found/fixed 2026-09-14 (SWH, LJP, Arktek); #5 is a bug in a sibling repo (InstallrHub Dashboard), not marketing-agent"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c8ed8129-d200-41a1-b91c-cfea43b2604b
  modified: 2026-09-14T16:50:29.675Z
---

Found in one session (2026-09-14) chasing several "why don't these numbers match" reports for SWH,
LJP and Arktek. Each has a different root cause; don't assume any single explanation covers all of
them. See [[project_client_reports_eligibility_gate]], [[feedback_design_performance_data_durability]].

**1. Intake name ≠ display name → a client's Leads reads 0.** `usePeriodActivityTotals.js` matched
`lead_intake_events.retainer_client_name` against `clients.name` directly. SWH's intake wrote "SWH
Electrical" but `clients.name` is "SWH Electrical Solutions"; LJP's intake wrote "LJP" against
"LJP Plumbing & Heating". Neither ever matched, so Leads was permanently 0 for both regardless of
window, while Booked (which joins on `leads.placed_with_company_id`, a real FK) stayed correct.
**Fixed** (PR #776): the hook now discovers each client's real intake-time alias(es) from
`leads.retainer_client_name` where `placed_with_company_id` matches, instead of assuming
`clients.name` is it.

**2. A booking gets declined/reassigned after the fact → per-campaign Booked reads too HIGH.**
`ad_windowed_totals`'s per-ad `leads_booked` is a naive count (who booked off this ad), not "who
currently holds the survey". The RPC appends ONE client-level correction row ("Survey count
reconciled to placement record") with no campaign/ad attached, so a client-level sum (Client
Reports, `useClientReport.js`) nets out correctly, but any per-campaign/per-ad breakdown
(Performance's campaign table) couldn't apply that correction and showed the pre-correction,
too-high number. Confirmed for LJP: raw per-ad sum said 4, true count (`placed_with_company_id`)
was 2 — 2 bookings (Laurie Smith, Ben Vincent) were declined and released back to the open
marketplace. **Fixed** (PR #778): `usePerformanceData.js`'s `trueBookedByAd` re-traces each
currently-placed booking back to its originating ad the same way the RPC's own `claim_corrected`
CTE does server-side, frontend-only, no migration. Verified against LJP's real data before
shipping. NOTE: the underlying RPC-level gap is unchanged — `campaign_windowed_totals`/
`creative_windowed_totals`/`tech_windowed_totals`/`breakdown_windowed_totals` still carry the same
class of bug per the pre-existing known-issues.md entry; only Performance's per-ad table is fixed.

**3. An ad hasn't synced yet (or was archived) → per-ad Leads reads too LOW vs the client total.**
The per-ad table (`PerformanceTable.jsx`) can only show a lead if `ads_ads` already has a row for
the ad it came from. A lead intake event with a real-looking `utm_content` but no matching
`ads_ads.external_id` (brand-new ad, sync hasn't caught up; or an archived ad Meta's `/ads`
endpoint no longer returns, same class as the known frozen-thumbnail issue) counts in the
client-level total but was invisible in the per-ad breakdown. Confirmed for SWH (29 total, 27
across visible rows) and Arktek (same shape, -3, one lead same-day from an unsynced ad). **Handled**
(PR #779), not "fixed" in the sense of making the ad appear sooner: `trueLeadsByClient` computes
the true per-client CRM count and a synthetic "Unattributed (ad not yet synced)" row carries
exactly the gap, so the column always sums to the true total instead of silently falling short.
Self-resolves (the row shrinks/disappears) once the ad actually syncs.

**4. DB vs Meta is a separate, unrelated axis.** `LeadFigure` (`src/components/ui/LeadFigure.jsx`)
shows "29 (30)" = our CRM count with Meta's `conversions` in brackets, a normal small gap (here
~3%, well under the 10% warn threshold from `lib/leadBasis.js`). Don't confuse this with gotchas
1-3 above — it's a different reconciliation (our tracking vs Meta's), already well-instrumented
with its own gap badge, and was NOT the cause of any of the bugs found this session.

**5. A DIFFERENT repo can be counting from the wrong table entirely.** InstallrHub Dashboard's own
"Arktek leads" view showed 47 against marketing-agent/Meta's 29 for the same window. Traced
directly against the shared DB (not that repo's code, not cloned here): (a) genuine duplicate
`leads` rows per name+postcode — one properly placed (`placed_with_company_id` set, agent
assigned, `booking_type='retainer'`), one an orphaned `status='Available'` row never actually
confirmed with anyone, still carrying `retainer_client_name='Arktek'` from creation time; (b) even
filtering to genuinely-placed rows only reached ~12, because `leads` (the CRM/marketplace booking
pipeline: available → claimed → booked → outcome) and `lead_intake_events` (the raw ad-attributed
enquiry log marketing-agent's Leads count is built from) are different tables measuring different
things and were never 1:1. **Not fixed here** — different repo, Charlotte passed it to Serafim
directly. `cross_agent_notes` insert was attempted and confirmed blocked (Supabase MCP is
read-only for writes in this environment) — logged in this repo's known-issues.md instead
(`[high / not this repo]`, 2026-09-14). Worth checking that entry to confirm whether it's since
been fixed on his side before assuming this pattern is resolved.

**How to apply:** when a client's numbers don't match between two surfaces, identify WHICH of
these five shapes it is before touching code — they look similar (two numbers disagreeing) but
have completely different causes, fixes, and "which number is right" answers. For 1-3 (all inside
marketing-agent), the fixes are shipped, so a genuinely fresh discrepancy of this shape now points
at something new, not a regression of these. For 5, remember `leads` and `lead_intake_events` are
NOT interchangeable concepts anywhere in this schema, not just in the Hub's query — a future
marketing-agent feature that casually joins/compares them needs the same caution.
