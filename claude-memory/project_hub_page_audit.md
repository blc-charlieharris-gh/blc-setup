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
