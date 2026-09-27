---
name: project_resubmit_lands_as_greentide
description: GHL sometimes fires ghl-new-lead-webhook twice for a retainer lead; the 2nd fire says Location "Green Tide Energy" and is filed as greentide
metadata:
  type: project
---

On 2026-09-22 two NIBE leads (Hugh Felton `e1mL6wDlNXHn1hSEMjdQ`, Wayne Middleditch `I3WBMnduncQKLaAgbsk5`) got a second `ghl-new-lead-webhook` call ~50s after the first, with NO second `meta-lead-webhook` call (so not a resubmit). The second call had Location "Green Tide Energy", tags `retainer, existing, new`, empty utm_medium and the ad set id in utm_campaign, so it was filed `lead_source='greentide'`. The webhook's dedup key hashes Location, so it wasn't caught.

**Why:** reporting-only. Green Tide counts +2 for 22 Sep. Dialer and clear-lost triggers were checked and did no harm (ON CONFLICT kept the retainer tag). A full-history check found only these 2 confirmed, plus 2 ambiguous existing-contact cases (Colin Bridges 2026-05-04 Renerji, Mankaji Gurung 2026-08-23 Arktek).

**How to apply:** handed to Serafim on 2026-09-23 (webhook is in his repo; fix is in GHL workflows + an optional guard + cleanup of the 2 rows). Charlotte said not urgent. Don't re-investigate; ask whether he fixed it and cleaned up the rows. Per-ad double count is already fixed by the one-per-person-per-day migration. See [[project_greentide_lead_pipeline]].
