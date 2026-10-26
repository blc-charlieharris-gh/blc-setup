---
name: feedback_grid_place_items_collapses_img
description: An img with max-width:100% inside a display:grid tile (place-items:center) renders 0x0; use flex centring
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0037a293-21b8-4906-bed8-68d6ef693b1a
  modified: 2026-10-26T17:41:52.495Z
---

Centring a badge `<img>` (width/height attrs, `max-width:100%`, `max-height`) inside a tile with `display:grid;place-items:center` made every badge 0x0 on the Jones and Baker trust strip (10-26). The images had loaded (`complete`, naturalWidth > 0). Switching the tile to `display:flex;align-items:center;justify-content:center` fixed it.

**Why:** the screenshots looked like a headless SVG decode problem, and time went on Chrome flags before the real cause turned up.
**How to apply:** when images come out blank in a headless check, run `--dump-dom` with a script that reports `naturalWidth` and `getBoundingClientRect()` before blaming Chrome. Centre logo tiles with flex. Related: [[feedback_headless_chrome_canvas_tests]]
