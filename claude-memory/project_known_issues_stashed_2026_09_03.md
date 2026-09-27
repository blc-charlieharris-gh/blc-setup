---
name: project_known_issues_stashed_2026_09_03
description: "marketing-agent shared tree has a stash (stash@{0}) with real unmerged known-issues.md findings buried inside mostly-stale drift; needs pulling out before lost"
metadata:
  type: project
  originSessionId: 73927149-6fd2-4589-a2cc-2836113068a6
  modified: 2026-09-03T16:14:39.360Z
---

Reported by another session (2026-09-03) working on `feat/swh-story-photo-and-sharpen`, verified real: `git stash list` in `/Users/charlotteharris/Documents/BLC/marketing-hub/marketing-agent` shows `stash@{0}` labeled "full-tree stash to unblock main merge for feat/swh-story-photo-and-sharpen".

That session stashed pre-existing uncommitted drift found in the shared tree while clearing space to merge their own branch, rather than touch or discard it (right call per [[feedback_shared_scratch_docs_get_clobbered]]/[[feedback_shared_worktree_stale_agent_reads]] precedent).

**Most of the stash is stale and safe to ignore**: older, already-superseded versions of `src/lib/onboardingEmails.js`, `src/lib/actions.js`, `src/hooks/useActions.js` — confirmed behind what's already merged on `main`.

**One part is NOT stale and matters**: `.claude/docs/known-issues.md` has ~90 lines of real, still-unmerged findings sitting in that stash, including one about onboarding data being silently dropped in InstallrHub Dashboard's `register-installer`.

**Why:** a stash is easy to lose track of — it doesn't show up in `git log`, doesn't get reviewed in a PR, and sits invisibly until someone thinks to check `git stash list`. The known-issues.md content inside it is genuine work product (a real bug finding), not drift, and risks being buried/forgotten if the stash itself is ever dropped or the shared tree gets cleaned up.

**How to apply:** before this stash is dropped or the tree is reset, pull `.claude/docs/known-issues.md`'s content out specifically (`git stash show -p stash@{0} -- .claude/docs/known-issues.md`) and merge those ~90 lines into the live file on `main`, since they document a real onboarding data-loss bug worth tracking. The `onboardingEmails.js`/`actions.js`/`useActions.js` versions inside the same stash can be discarded once confirmed still behind main.
