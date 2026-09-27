---
name: feedback_visualkey_mergemap_collapse
description: "When looking up a creative in mergeMap-collapsed perf data, collapse the lookup key through mergeMap too, or it silently misses"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 754caa99-d744-4733-9006-3ab1035c0c09
---

In the marketing-agent, anything that groups ads into "visual creatives" (`buildCreativeGroups` / `campaign_creative_cpl` aggregation in `useCreativeTestData`) keys the result map by the **mergeMap-collapsed canonical** visual key: `const vk = mergeMap.get(visualKey(row)) || visualKey(row)`.

**Why:** A creative re-uploaded to Meta gets a fresh `creative_external_id`/thumbnail, so `visualKey` differs per upload; the operator's manual merges in `creative_merges` (the mergeMap) unify them under one canonical (the smallest member key).

**How to apply:** If you hold a raw visual key (e.g. `creative_tests.visual_key`, which starts as `upload:<uuid>` and is backfilled to a real key on tagging) and want to look it up in a mergeMap-collapsed map, you MUST collapse it first: `const k = mergeMap.get(rawKey) || rawKey`. Looking up with the raw key silently misses after a merge (canonical != raw), so a CPL/metric reads null with no error. Bug found + fixed in `useCreativeTestData` 2026-06-24. Related: [[project_marketing_bigbuild_prs]].
