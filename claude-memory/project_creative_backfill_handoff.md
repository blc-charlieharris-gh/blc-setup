---
name: project_creative_backfill_handoff
description: Creative backfill (originals into the Library) handed to the audit session 2026-09-27 by blc-ee; files, rules, order
metadata:
  type: project
---

On 2026-09-27 Charlotte handed the whole creative backfill to the Hub audit session (blc-ee closed). It ends with her ORIGINAL files uploaded into the creative Library and linked to their ads.

Files (outside the repo): `~/code/BLC/docs/creative-workflow/backfill/` — README.md (read top to bottom, "Handed off" section has order + file map), `page/template.html` + `page/page-data3.json` (176 cards, current) + `page/backlog45.json` (B1-B45). The CSV is a stale first pull, ignore it. Live list page Charlotte uses: https://claude.ai/artifact/8PEWFZuLQJnHBM36uJDyAS (republish with that `url`).

**Rules (Charlotte):** the Hub holds NO originals (creative_tests files are screenshots, fallback only). One hook = one file = one Library item. Helix (own ads) and Eco Green (ex-client) out. No Canva. "Running" = spent in last 3 days, not status. Videos carry the card number at the start of the file name, backlog files carry B<n>, images any name (match by picture). Never renumber cards once she's naming files; a re-pull maps onto the old numbers.

**Order:** Matcher data audit + clean-up -> re-pull list (keep numbers) -> merge Library branch (feat/creative-workflow-preview) + apply its migration -> Charlotte shares a Google Drive folder -> match files (number in name first, then picture; she confirms unsure) -> upload + link each asset to its ads via creative_launches (respect creative_hooks) -> AI tag.

**Why:** she wants the Library to hold real originals linked to performance. **How to apply:** this runs as page 5 of [[project_hub_page_audit]], after the pages 1-4 rescan fixes.

Status 28 Sep: Library + migration merged and live (#1068, #1071: creative_assets.hook + imported, creative_launches.ad_id unique + meta_ad_id unique). Waiting on Charlotte: finish Matcher grouping + hooks, then her Google Drive link. Backfilled assets should be inserted with imported=true (kept out of the weekly target). When linking ads, copy any existing 'visual:ad:<ext>' ingredient tags onto 'asset:<id>' rather than re-tagging.
