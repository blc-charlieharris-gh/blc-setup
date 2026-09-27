---
name: project-concurrent-sales-pipeline-session
description: Charlotte has another active marketing-hub session concurrently working on a sales pipeline (flagged 2026-09-17) — check before touching sales_* tables/pages
metadata: 
  node_type: memory
  type: project
  originSessionId: c8ed8129-d200-41a1-b91c-cfea43b2604b
  modified: 2026-09-17T07:13:15.429Z
---

Flagged directly by Charlotte 2026-09-17: she has a separate, currently-active `marketing-hub`
session working on a **sales pipeline**. Scope of "sales pipeline" wasn't detailed further this
session, likely `sales_opportunities`/`sales_lead_intake_events`/`installer_prospects`/`sales_*`
tables and their frontend pages (per the InstallrHub B2B recruitment domain touched this same
session), but could be broader.

**Why:** this repo has no file-locking; two concurrent sessions editing the same area (or even
just the same shared-DB tables via migrations) risk clobbering each other's work, the same class
of risk already documented in [[feedback_shared_worktree_stale_agent_reads]] and
[[feedback_shared_scratch_docs_get_clobbered]].

**How to apply:** before starting substantial work touching `sales_*` tables, `installer_prospects`,
or their frontend pages/hooks, check `git log`/`git status` for recent unfamiliar commits or
in-progress branches first, and confirm with Charlotte whether that other session is still active
before assuming a clean slate. This memory itself will go stale once that other session ends —
treat it as a point-in-time flag, not a permanent constraint, and verify current state rather than
assuming this is still true.
