# Hub audit: where we are (end of 29 Sep)

## Why the last audit was so big, when we'd been going page by page

You were right to expect fewer problems. Three things caused it:

1. **A lot was built beside the audit, not through it.** While we audited pages 1-7, about 55 changes
   went live (#1109 to #1164): the whole creative workflow (Library, launches, tests, Bank, tasks,
   flagged notes, Urgent), Lead Intake redesigns, Status tools, the cost calculator. Each was
   checked on its own when built, but not against the pages around it. Most findings sat in that new
   code, and in the places where two new pieces met (for example two "tag the live ad" windows built
   a day apart).
2. **The final pass used a stricter checklist than the page-by-page passes.** The early pages were
   audited mainly for "are the numbers right". The final pass also asked: does every failure say so
   in words, is there only one definition of each rule, is there old code left behind, is anything
   duplicated, is it easy to use. Those questions find many small things in any page.
3. **Five people-sized chunks read everything at once, down to file and line.** That produces a long
   list: about 150 items. But most were small (a label, an unused function, a missing error line).
   Around 15 were real bugs that could give a wrong answer or lose data.

The good news in the same audit: the numbers that matter agree across pages (Status and Lead Intake
matched for every client), every earlier fix held, and the live data is clean.

**To stop this repeating:** new features now go through the same checklist before they merge, and
from page 8 on, anything built mid-audit gets folded into that page's check.

## What was fixed (all merged except the last one)

- Tests that never started (New campaign + ad id pasted the same day) now start themselves.
- Deleting a creative no longer silently deletes its launches and task designs.
- Failed reads everywhere now say "Couldn't load ..." instead of showing £0, "OK" or a default.
- Alert emails only count as sent when they were sent.
- Status: no more "0 -> 0, OK" on a failed check, no "All clear" beside amber rows.
- Find the missing leads records what it actually found.
- Performance: rank badges use each client's own targets and tech; 11 clear columns by default;
  clicking a number opens a list that matches it.
- One tagging window, one hook check, one "waiting for the live ad" rule.
- By creative view: one clear card, one row per client.
- About 300 lines of old code removed.

## Pages
- Pages 1-7: DONE (audited, rechecked, final audit, all fixes built).
- Page 8 Targeting: audited, 3 decisions waiting (below), then fixes.
- Next: page 9 Coverage.
