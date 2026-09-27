---
name: placed-with-company-id-survey-truth
description: "leads.placed_with_company_id (join via clients.company_id) is the correct \"who currently holds this survey\" field, not retainer_client_name/retainer_client_id/booking_type"
metadata: 
  node_type: memory
  type: reference
  originSessionId: d0b8edcf-2e99-4a02-bfa2-29d405641c90
  modified: 2026-08-24T17:58:25.940Z
---

For any survey/booking count in marketing-agent or the InstallrHub DB: use `leads.placed_with_company_id` (a `companies.id`), dated by `COALESCE(transferred_at, booked_at)`. Join to the ads-side `clients` table via `clients.company_id`, a real FK, no fuzzy name-matching needed.

**Why the other fields lie:**
- `retainer_client_name` and `retainer_client_id` are stamped once (intake or first assignment) and never cleared when a lead is declined and released back to the marketplace. A released lead still reads as the original client's forever.
- `booking_type` flips `'retainer'` → `'published'` on release, so it looks like a good "still placed" signal, but it's equally wrong the other way: a lead individually claimed off the open marketplace (not via the direct retainer-assignment flow) can be genuinely placed with a client while `booking_type` stays `'published'`.
- Whole-adset attribution links (`ads_client_attribution_links`, `transfers='surveys'`) blindly attribute every claimed survey off the shared adset to the linked client, even when the survey's actual `placed_with_company_id` says it ended up somewhere else entirely.

`transferred_at` is real and populated, but only for individually-routed hand-offs (marketplace-origin, `transferred_from='marketplace'`), not direct retainer assignments, where it stays null and `booked_at` IS the hand-off moment. That's why `COALESCE(transferred_at, booked_at)` is required, not `booked_at` alone.

Verified 2026-08-24 against three clients' own reports/sheets (Arktek, HQ Group, Gas Worx), all matched name-for-name once keyed this way. See [[feedback_survey_count_root_cause_2026_08_24]] for the fix locations.

**Limit found 2026-09-25:** marketplace CLAIMS never set it. All 811 `slots` rows with `status='claimed'` have `claimed_by` = a company id while the linked lead's `placed_with_company_id` is NULL. So for surveys an installer claimed off the open marketplace, the truth is `slots.claimed_by` (+ `claimed_at`); `placed_with_company_id` covers retainer and individually transferred surveys. Surveys we book for a marketplace client from their own Green Tide campaign are booked like a retainer's, so the marketplace rounds count (`marketplace_rounds_progress`) uses `placed_with_company_id`.
