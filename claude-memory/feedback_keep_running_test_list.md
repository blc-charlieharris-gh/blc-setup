---
name: feedback-keep-running-test-list
description: "Charlotte wants one running test list of everything built (Meta in the Hub + related), kept in the repo and shown in reports"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0576305c-b366-4b9c-8fa5-540ae6921ae3
  modified: 2026-10-28T10:00:04.576Z
---

Keep ONE running list of what's built and still to test: marketing-agent `.claude/docs/test-list.md` (renamed 10-28 from meta-in-hub-test-list.md: one list for every area, grouped by area, each line = what to do, what you should see, status, date/PR). Every PR that ships something people use adds its checks there (plain click-steps, what to look for), and ticks items once verified live. Each report ends with the open items that matter now.

**Why:** Charlotte 10-25: "keep a list of all these tests ... its important to get this right as we could get notification to pause, then get a few cancellations which then mean it needs to go live again". She lost track of what had been built vs tried.

**Widened 10-27:** this isn't only for Meta. Every build and fix since the hub audit started (09-27) that hasn't been proven working live needs to be on a test list, and the checks should happen during real use (real launches, real clients), never by spending money just to test. Charlotte wants Meta finished before the check-back audit of the 10-21 to 10-27 builds.

**How to apply:** write real-life cycles, not just single clicks (pause -> cancellations -> back on -> pause again). Related: [[project-meta-in-hub-test-list]].
