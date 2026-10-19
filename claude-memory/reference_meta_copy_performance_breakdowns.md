---
name: reference_meta_copy_performance_breakdowns
description: Per-text ad results come from Insights breakdowns body_asset/title_asset/description_asset; rank by in-ad index; AI "Generate text" assets can't be told apart
metadata:
  type: reference
---

2026-10-19, `meta-access/copy_performance.py`: Insights `level=ad` with `breakdowns=body_asset` (or `title_asset`, `description_asset`) returns spend/clicks/actions per text. Rank texts by in-ad index (its leads vs what its spend share in the same ad predicts), not raw CPL, which mostly reflects the account. Meta AI tools live in `creative.degrees_of_freedom_spec.creative_features_spec` (`text_optimizations` = AI rewriting, `text_translation`). Texts added from Ads Manager's "Generate text" are saved as ordinary assets, so the API can't flag them. Standard sets per product are in `meta-access/docs/brief-hub-ad-copy-performance.md` (Hub build with blc-49's audit plan).

Gotcha: `meta_api._paginate` only ever returns the first page (it looks for `next` inside `cursors`); page with `paging.cursors.after` while `paging.next` exists instead.
