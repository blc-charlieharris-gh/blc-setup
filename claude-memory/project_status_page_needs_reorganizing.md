---
name: status-page-needs-reorganizing
description: "Status page (/status) conflates several unrelated health checks with no shared visual language; Charlotte wants it reorganized for clarity, not urgent"
metadata: 
  node_type: memory
  type: project
  originSessionId: 696dfa91-015b-4c1c-8308-6a8e631cf4a2
  modified: 2026-09-20T16:53:08.247Z
---

Charlotte asked (2026-09-20) for a note to organize `/status` (`src/pages/Status.jsx`) so it's clearer what's actually being shown. Not urgent, no session has started this yet.

**Why:** during a long audit session (2026-09-20) fixing several real reconciliation bugs, it became clear the page stacks four genuinely different concerns with no visual separation:
1. The "Ads (tracked clients)" table — server-computed, every-2-hours, drives the sidebar nav badge (`redStatusIssues()` in `lib/statusHealth.js`).
2. "Lead pipeline (ads → database)" card — a single headline Meta-vs-DB number, Green-Tide-only by design.
3. Per-client "Lead reconciliation" tables (Instant forms / Landing page) — computed live in-browser (`useLeadReconciliation.js`), much more detailed than #2, same underlying concept at a different zoom level.
4. "Lead field mapping" card — a completely unrelated check (data completeness, not delivery), covers every client including Green Tide/InstallrHub.

**The concrete confusion found:** the sidebar's "(N)" badge only counts issues from #1 (server-side, 2-hourly). #2, #3 and #4 can all show red/amber on the page with zero effect on that badge — Charlotte flagged this directly ("status in tab menu says (2)... but the page is peppered with red"). Not a bug exactly, more a design gap: the badge and the page are answering different questions and look like they should agree.

**How to apply:** next time this page is touched for real work, consider: visually grouping #1 (drives the badge) separately from #2-4 (informational, browser-computed); deciding whether the badge should reflect more than #1, or whether the page should make clearer which parts feed it; and reviewing whether #2 and #3 (same underlying concept, two different components) should be merged or at least visually linked so they don't read as unrelated checks.

Related: [[project_installrhub_reconciliation_pipeline]] if that gets written up — several of the underlying data bugs (InstallrHub's separate B2B pipeline, null retainer_client_name, B2B contact_source tagging) were fixed the same session this note was written, PRs #841/#843/#844.
