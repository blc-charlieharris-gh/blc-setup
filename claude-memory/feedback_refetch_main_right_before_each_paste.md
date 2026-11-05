---
name: feedback-refetch-main-right-before-each-paste
description: "Before handing Charlotte each edge fn paste, fetch main again, merge it in and rebundle; a check done minutes earlier missed Serafim's newer deploy"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 5a93a102-048e-485c-8b0b-f746f427400e
  modified: 2026-11-05T11:14:37.881Z
---

Right before EACH edge function paste: `git fetch`, `git log HEAD..origin/main -- <fn> _shared`, merge main if anything landed, rebundle, then compare the live function with the new copy (nothing live missing from it).

**Why:** 11-05 survey returns: I compared live installer-leads-view with main, then gave her a copy bundled earlier. Serafim's Calling list tab (#3228) had merged and been deployed (v123) in between, so her paste (v124) switched it off. She caught it by asking "we haven't lost what Serafim deployed?". Fixed with v125 after merging main.

**How to apply:** the comparison must be against the exact file on her clipboard, done after a fresh fetch, for every function in a multi-paste run (not once at the start). Links: [[feedback-check-serafim-changes-against-hub]], [[feedback-merged-is-not-deployed]], [[feedback-clipboard-shared-between-sessions]].
