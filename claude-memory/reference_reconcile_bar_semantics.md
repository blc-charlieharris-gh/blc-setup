---
name: reference_reconcile_bar_semantics
description: Performance ReconcileBar meaning — bridge (attributed leads) can exceed Meta conversions; Retrofit reads 100% because it runs Meta lead forms
metadata: 
  node_type: memory
  type: reference
  originSessionId: ca1138af-30d6-42da-8c26-68ef2011a73e
---

The Performance ReconcileBar is per selected client and shows `bridge` (DB leads tied to an ad, via `ad_performance_with_leads.leads_generated`, i.e. utm_content carries the ad id) vs `meta` (Meta's own `ads_insights_daily.conversions`). It IS attribution, not lead loss (loss lives on Status).

Two non-obvious facts that trigger "is this right?" questions:
- **bridge can exceed meta** (e.g. "198 of 189"). Meta under-counts conversions (iOS ATT, consent, pixel/CAPI gaps) while the site form still captures the ad's UTM, so we attribute more real leads than Meta logged. Healthy, not an impossible >100%. The old copy literally read "198 of 189"; fixed 2026-06-25 to "X leads tied to an ad vs Y Meta conversions" + label "Fully attributed (Meta under-counts)".
- **Retrofit Group reads exactly bridge==meta at every window** (4/4, 14/14, 27/27) because that account runs Meta **lead forms** (instant forms) where the ad id is always captured, so 100% attribution is genuine. Greentide (website forms, UTM-based) shows the normal small gap (~96%). So a single small client showing "27 of 27" is correct, not a stuck/duplicated number.

The numbers DO vary by date window (reconcile_leads filters p_from/p_to). See [[reconcile_direction_asymmetric]] and [[db_meta_underreporting_attribution]].
