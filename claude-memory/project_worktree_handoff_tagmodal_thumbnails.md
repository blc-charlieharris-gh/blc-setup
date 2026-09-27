---
name: project_worktree_handoff_tagmodal_thumbnails
description: "Cross-session git state 2026-07-30 pm; the shared marketing-agent working tree is passed between sessions, fetch before acting and don't sweep others' uncommitted edits into your commits"
metadata: 
  node_type: memory
  type: project
  originSessionId: e306d040-3199-4d38-bd90-f2686f851312
---

Handoff from a parallel session (2026-07-30 pm), about the SHARED marketing-agent working tree
(`/Users/charlotteharris/Documents/BLC/marketing-hub/marketing-agent`) that multiple Claude sessions edit:

- **feat/tag-modal-matcher-hooks** (1 commit a2015a4, only `TagLiveAdModal.jsx`) was pushed off latest main.
  MERGED as **#460** "Show Creative Matcher hook in Tag-live-ad picker". Resolved.
- **Stray uncommitted edit warning:** when they branched, an uncommitted edit to `.claude/docs/serafim-pending.md`
  (carried from `docs/handoff-2026-07-30-thumbnails`) was already in the working tree. RESOLVED this session:
  the working-tree copy was verified byte-identical to my batch branch `docs/serafim-batch-clientlink` (no stray
  thumbnail content mixed in), so I discarded the working-tree overlay, content preserved on the branch.
- They moved HEAD off `docs/handoff-2026-07-30-thumbnails` to the feature branch; HEAD is now back on `main`.
- **feat/matcher-no-hook-count** (1 commit): `useNewCreativeCount` return type changed from a plain number to
  `{ newCount, noHookCount }`. Only consumer (PerformanceTable) updated in the same commit; any other in-flight
  caller of that hook needs the destructure too.
- **InstallrHub-pool hook backfill still stands:** already-set InstallrHub creative hooks need re-saving (or a
  Serafim-gated UPDATE) to land in the InstallrHub pool. See [[feedback_visualkey_mergemap_collapse]].
- The parked working-tree `.claude/docs/serafim-pending.md` is now noise: my batch is canonical on main (#463).

**Lesson / standing practice:** the working tree is shared. `git fetch` before acting; commit ONLY your own
files (I use the temp-index-on-origin/main flow, see [[feedback_commit_via_temp_index_on_main]], and isolated
scratchpad worktrees for multi-file edits); never `git add -A` in the shared tree or you sweep another session's
uncommitted work into your commit.
