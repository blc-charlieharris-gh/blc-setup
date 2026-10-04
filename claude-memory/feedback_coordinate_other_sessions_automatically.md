---
name: feedback_coordinate_other_sessions_automatically
description: "Charlotte often runs 2-3 Claude sessions at once; at prime and handoff (any repo, incl. marketing-agent's own skills) list and message them unprompted, one writer per repo's handoff"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 96fe6ac9-c04b-4843-addc-b53f56151d40
  modified: 2026-10-03T18:54:26.874Z
---

Charlotte 2026-10-03: she was typing "note two other active sessions so speak to them to ensure clean handoff and
working tree at sessions end" every time. She doesn't always have other sessions, but often does (e.g. Hub,
site-installrhub, Meta sync).

**Why:** three sessions on 10-03 (marketing-agent x2, installrhub-static) needed one writer per repo's
handoff/CHANGELOG/plan/known-issues, separate branches/worktrees, and leftover branches cleared, or they overwrite
each other and leave dirty trees.

**How to apply:** at session start (prime) run ListAgents; if any sessions, SendMessage each once: my folder +
branch, ask theirs and any local branches/worktrees/uncommitted files, house rules (own branch/worktree if sharing
a repo, ONE writer per repo's handoff docs, others send a summary to fold in, message before writing, confirm
branches merged + tree clean before ending). At handoff,

**One voice per action (Charlotte 2026-10-03, "stop duplicating what I need to do"):** when two sessions share a
job (e.g. site PR + matching Hub PR), only the session that OWNS the action tells her to do it (merge X, test Y).
The other session never repeats it: it says one line, "that's in the other session's message", or stays silent.
Agree who owns each ask by SendMessage BEFORE either tells her. Every merge ask names the repo plus PR number, and
cross-repo merges get ONE combined ordered list from one session (e.g. "1. site #114, 2. Hub #1418"), because
two sessions each asking her to merge led to her merging the wrong-order PR (Hub #1418 before site #114, so live
links 404'd). When a peer's message just repeats an ask already given, don't relay it to her again. At
handoff, collect their summaries and tell them when done. Built into
the shared prime-project/handoff skills (blc-setup/shared-agent-skills, 10-03); marketing-agent's own handoff skill
(Serafim's) doesn't have it, so do it from this memory there. Related: [[feedback_peer_session_coordination_not_handoff]],
[[feedback_shared_scratch_docs_get_clobbered]], [[feedback_charlotte_plain_explanations]].
