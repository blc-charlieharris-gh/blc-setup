---
name: feedback_report_prose_no_adspend
description: "Client report PROSE must never state ad spend; cost per lead is the client's number, the budget behind it is ours"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: f0dddaa7-d145-49d2-a755-e210eb20d4f8
  modified: 2026-08-10T14:15:18.737Z
---

The client weekly report's generated prose (hero sub-line, summary draft, headline) must **never state ad spend**. Charlotte cut it on sight, 2026-08-10: "no we cannot include adspend ... as in dont say it". Lead with cost per lead alone: "Leads averaged £29.29 each this week, below the £60–£150 range we'd expect in month one."

**Why:** cost per lead is the client's number. The spend behind it is our media budget, and a report that says it in a sentence puts that budget in something they can forward. A stat CARD is a different thing (operator-picked, deniable, easy to toggle off); a sentence is us telling them.

**How to apply:** `costBeat()` in `src/lib/reportNarrative.js` takes cplV, never spend. A test in `reportNarrative.test.js` asserts no tone can put "ad spend" or a week's spend figure into heroSub / summary / headline, so a regression fails the build. NOT covered: the "Since launch" Total-ad-spend tile and the "Ad spend" stat card are both still defaultOn, so spend is one click from visible and is trivially recoverable anyway (leads x CPL). If a client must not see the budget at all, those two need turning off in the stat picker per client.

See [[project_client_weekly_reports]], [[feedback_client_report_tone]].
