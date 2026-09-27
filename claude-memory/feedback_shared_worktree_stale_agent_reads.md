---
name: feedback-shared-worktree-stale-agent-reads
description: "A subagent (or ToolSearch/general Read) pointed at a shared, multi-session working tree can read files a prior turn already reverted, producing a confidently wrong audit"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 61afe38f-a213-4f49-98e7-f49da96d2c7e
  modified: 2026-08-27T10:59:00.029Z
---

When this session pushes its own edits to a separate branch/worktree and then reverts the shared main working tree back to HEAD (to avoid leaving unrelated diffs for other concurrent sessions in that tree, see [[feedback_shared_scratch_docs_get_clobbered]] for the underlying reason multiple sessions share one tree), a later subagent spawned with `cwd` pointed at that shared tree will read the REVERTED, pre-fix file content, not the merged state on `origin/main`. It has no way to know a fix was already shipped and merged elsewhere.

**Why:** discovered 2026-08-27 in marketing-agent, mid-session. After shipping `ClientCard.jsx`/`useClientOnboarding.js` fixes (sales_profile/solar_profile fetching, unfiltered criteria) via worktree-push-then-revert, a general-purpose agent was asked to audit "does the Clients page show everything the onboarding form asks?" against the same shared repo path. It reported the fixes as still broken, sales_profile still not fetched, criteria filter still live, because it read the reverted local files, not `origin/main`. The report was internally consistent and confident; nothing about it signalled staleness.

**How to apply:** when this session's own worktree-push-then-revert pattern is in play (or any time local files were deliberately reverted after being pushed elsewhere), don't delegate an audit of "current state" to an agent pointed at the shared working directory. Either do the audit directly with `git show origin/<branch>:<path>` yourself, or explicitly instruct the agent to read from `origin/main` (or the relevant branch) rather than the working tree, and say why: the working tree's HEAD does not reflect what's actually deployed.
