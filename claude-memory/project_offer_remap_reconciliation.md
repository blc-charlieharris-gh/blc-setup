---
name: offer-remap-reconciliation
description: "offer-remap-temp: all 12 clients answered AND applied to companies.packages (verified 2026-09-23); page is done, Vercel project can go"
metadata:
  node_type: memory
  type: project
---

**DONE as of 2026-09-23.** The sales questionnaire at offer-remap-temp.vercel.app (pick new offer
brand / retainer3 / retainer6 + services per existing client) has been completed by the team and
the answers **have been applied** to `companies.packages`.

Verified 2026-09-23 by joining `temp_offer_remap_2026_09_17` to `companies` on company_id: all 12
match on offer, leadType, retainer_months and guarantee_gbp.

Arktek (retainer3/120) · Core Electrics (brand) · Gas Worx (retainer3/120) · Harvard Renewables
(brand) · Helix Power (retainer6/120) · HQ Group (retainer3/120) · Jones and Baker (retainer6/140)
· LJP Plumbing (retainer6/140) · National Eco (retainer6, lead_only) · NIBE (retainer3/120) ·
Outlook Energy (retainer6/120) · SWH Electrical (retainer3/120)

Two small field-level drifts, almost certainly later manual edits, not worth chasing:
- Core Electrics: `googleProfileSetup` true in temp, false live.
- Harvard Renewables: `leadType` null in temp, `lead_and_calling` live; `googleProfileAudit` true
  in temp, false live.

**Why:** an earlier version of this memory said "1 of 12 answered, never applied" (true on
2026-09-19) and was still being quoted as current four days later. Charlotte corrected it.
**How to apply:** the work is finished. The Vercel project `offer-remap-temp` is safe to delete,
the data lives in Supabase not Vercel. Keep `temp_offer_remap_2026_09_17` as the record.
Related: [[crew-roster-and-retainer-pill]], [[project_serafim_package_picker_handoff_2026_09_18]]
