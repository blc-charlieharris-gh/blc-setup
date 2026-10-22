---
name: reference_meta_sync_skips_untracked_clients
description: "meta-sync only pulls clients with is_tracked=true, so a client being built (not Live) has no campaigns/ads in the Hub; ask Meta live instead"
metadata:
  node_type: memory
  type: reference
  originSessionId: bca769a8-87b5-4eb5-bf2e-6f75a9deee90
  modified: 2026-10-22T15:22:33.261Z
---

meta-sync's client query is `is_active = true AND is_tracked = true AND meta_ad_account_id not null` (supabase/functions/meta-sync/index.ts). A retainer client still onboarding (is_tracked false) has NO ads_campaigns / ads_ads rows, even with a linked account and a built campaign (Madola, Jones and Baker, 2026-10-22).

**How to apply:** anything that needs "has their campaign been built" before Live must ask Meta live: meta-assets-discover action `build_status` (ad_account_id, since) via hooks/useMetaBuild, added 2026-10-22 for the self-ticking Retainer build steps. Related: [[reference_meta_finance_special_category_rules]]
