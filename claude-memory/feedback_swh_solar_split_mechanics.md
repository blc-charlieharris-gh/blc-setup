---
name: feedback-swh-solar-split-mechanics
description: "How to split a combined website-factory service page into separate pages without hand-retyping HTML, and what has to stay in sync"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 11297753-1e82-475a-a9e8-3feccea1ffa2
  modified: 2026-09-03T13:46:46.771Z
---

When splitting a combined multi-topic service page (e.g. SWH's solar/battery/EV page) into separate pages in a website-factory client site, don't hand-retype the extracted HTML into the new PAGES.push blocks. These pages run 700+ lines of hand-written markup with inline SVGs and template-literal interpolations; retyping risks a broken attribute or mismatched quote that only shows up as a subtle render bug.

**How to apply:** Splice programmatically instead. Read build-pages.mjs as a line list in Python, locate each section's exact boundaries by unique marker strings (not hardcoded line numbers, they shift as you edit), extract each pillar verbatim to a temp file, do any text-level edits (image src swaps, added links) on the extracted text, then reassemble the new PAGES.push blocks as a plain string, and splice that string back into the line list to replace the original block. Verify with `node -c build-pages.mjs` before running the actual build. A depth-counting brace/tag matcher (count `<section` vs `</section>`) is more reliable than assuming a fixed line offset for where a section closes.

Two things to check whenever a client site's service list changes shape, this cost time to discover:
1. `SERVICE_LINKS` (or equivalent array) is usually the single source for BOTH the desktop dropdown and the mobile menu, rendered from one `.map()` each, so it only needs editing once.
2. The `<footer>` services column is typically NOT centrally sourced. It's duplicated in the shared page-wrapper function (used by every generated page) plus hand-authored copies inside hand-authored pages (home, about) that the nav-sync step does NOT touch (that step only regexes out the `<nav>`/mobmenu block, footer is out of scope). Grep for the footer's literal link list across every `.html` file, not just the generated ones, before considering the change complete.

**Why:** learned this building SWH's split ([[project_swh_website_imagery_pass]]) after finding the sync loop's own comment saying nav-sync is nav-only, and confirming via grep that the footer's exact link markup was duplicated verbatim in 3 places.
