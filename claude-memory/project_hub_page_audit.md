---
name: project_hub_page_audit
description: "Page-by-page Hub audit started 2026-09-27, tracker lives in the Hub repo at .claude/docs/hub-audit/ (moved in #1051)"
metadata:
  node_type: memory
  type: project
  originSessionId: 2207cf9e-b1b7-4849-a16f-6859302e071b
  modified: 2026-09-27T08:22:17.429Z
---

Charlotte started a page-by-page audit of the Hub (marketing-agent) on 2026-09-27: outdated copy/code, data accuracy, improvements, page-linked known issues, her own notes, cross-page connections (does a status/note/flag set here update everywhere else that shows it), archive candidates (AI Ops, Coverage, Placement likely). SOPs + Parameters to merge, with a new "Data sources" sub-tab for a cross-check with Serafim.

**Why:** she wants an accurate, top-end back end for InstallrHub and clients.

**How to apply:** read `marketing-agent/.claude/docs/hub-audit/README.md` first (in the repo since #1051 on 2026-09-27, so it travels between devices; update it inside each audit PR), it has the page list, status, tags (FIX/SERAFIM/DECIDE/ARCHIVE?) and working pattern. Fixes go in a worktree, one PR per page. Anything the app uses is Serafim's domain. After the last page, do a final sweep of EVERY open known issue until none remain and the tree is clean.

Guiding rule (Charlotte, 2026-09-27): single source of truth. Every fix should remove a second definition of a number, not add one (shared libs: lib/leadStats, lib/targets, lib/history, lib/changeLog).

Rate check (added 2026-09-27 after the Dashboard 7d lost rate slipped through the first pass as ~28% vs a true 10%): for every rate on a page, check the top and bottom count the SAME leads (lost/booked of the period's leads, not events dated in the period over leads arriving in it). Tracing where a number comes from is not enough.

State end of 09-27 (laptop session): pages 1-4 + nav done, settled rates live on Dashboard (#1058, params rates.bookDays/lostDays/cancelDays = 14/30/30; lost = marked lost whenever, age-gated, because lost dates are tidy-up batches). Queue: (1) Performance on settled_rates (table Lost col, pop-ups, Tech tab, red flags), (2) tech setting into targets/Today/Creative Testing/Targeting map, (3) RE-AUDIT pages 1-4 with the rate check (Charlotte 09-27, after the lost-rate miss), (4) page 5 Creative Testing. Charlotte 09-27: cancelled surveys and cancellation rates ARE reported, per creative too (so cost per chargeable goes, cancellations stay visible). Charlotte runs the other session (blc-ee) herself; don't message it unless it writes first.

Process (Charlotte 09-27): after finishing each page, do a quick scan audit of ALL completed pages to spot-check / cross-check issues (rates, shared numbers, links between pages). The re-audit of pages 1-4 is the first one.

State 28 Sep (laptop, before device switch): pages 1-4 done + rescanned; page 5 Creative Testing DONE (#1065 Matcher clean-up, #1068-#1074, see [[project-creative-workflow-preview]]). NEXT: the pages 1-5 scan audit (cross-check, include Actions onboarding events build), then page 6 Status. Parked to the end: Breakdowns tab (Serafim meta-sync), creative backlog, client reports (page 19), Tech tab cost/booked basis, Meta thumbnail refresh at source (Serafim). README page table row 5 is stale; 05-matcher.md is current.
