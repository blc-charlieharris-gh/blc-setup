---
name: project_active_marketing_agent_sessions
description: "Concurrent active work sessions in marketing-agent as of 2026-09-03: SWH imagery (shared tree, uncommitted), nurture SMS (own worktree), gasworx landing (new worktree)"
metadata: 
  node_type: memory
  type: project
  originSessionId: e1d1c92c-a0bf-4805-8536-1cd9ac98343d
  modified: 2026-09-04T16:21:11.611Z
---

**Update 2026-09-04: all three resolved/merged.** SWH's work committed and merged to main (#743-751,
including the legal/compliance pass, see [[project_swh_legal_compliance_cleanup]]). Nurture SMS work
merged too (#740-742, #747). Gasworx landing page (see
[[project_gasworx_energy_savings_landing]]) is deployed live and merged to main (squash PR #752). The original "landing page = template.html" note below is
now wrong, "landing page" this session meant a genuinely separate new file,
`clients/gasworx/energy-savings.html`, not the homepage.

Original 2026-09-03 snapshot, kept for the worktree-isolation pattern:

As of 2026-09-03, three concurrent lines of work in `marketing-hub/marketing-agent`:

1. **SWH website** (Charlotte's own session) — lives directly on the SHARED main working tree
   (`marketing-hub/marketing-agent`, not a sub-worktree), branch `feat/swh-story-photo-and-sharpen`,
   all uncommitted. See [[project_swh_website_imagery_pass]]. Because this is uncommitted on the
   shared tree, do NOT `git checkout`/`reset`/`clean`/pull over that tree from another session, and
   do not run gasworx or other work directly in that root checkout, it would collide with these
   in-progress edits.
2. **Email/SMS (nurture) work** — has its own dedicated worktree at
   `.claude/worktrees/nurture-sms-date-steps`, branch `fix/defer-delay-hours-drop`. See
   [[reference_nurture_engine]].
3. **Gasworx landing page** — new, started this session. Since the shared root tree is occupied by
   the uncommitted SWH work, created an isolated worktree at `.claude/worktrees/gasworx-landing`,
   branch `feat/gasworx-landing`, based off `origin/main`.

There is also a `.claude/worktrees/clients-kanban` worktree (branch `docs/2026-08-17-handoff`) not
flagged as active by Charlotte this session, status unconfirmed, don't assume it's stale without
checking.

**Why:** this repo's working tree is shared across parallel Claude sessions (see
[[feedback_shared_worktree_stale_agent_reads]], [[project_worktree_handoff_tagmodal_thumbnails]]);
tracking which branch/worktree each concurrent task owns avoids one session clobbering another's
uncommitted work.

**How to apply:** before starting new work in marketing-agent, check `git worktree list` and
`git status` on the root tree first. If the root tree has uncommitted changes not related to your
task, work in a new `.claude/worktrees/<name>` worktree instead of the shared root.
