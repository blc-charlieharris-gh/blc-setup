---
name: feedback_squash_merge_hides_from_commit_match
description: "git branch --merged and exact commit-subject matching both under-detect shipped work when GitHub squash-merges use the PR title, not any branch commit, as the merge message"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 9c6e7f66-dfcd-4521-867d-936b0a4d3bfd
  modified: 2026-08-19T16:17:43.905Z
---

When auditing unmerged branches in marketing-agent (2026-08-19, 170-branch cleanup), matching each
branch's own commit subjects against `origin/main`'s commit log looked like a solid signal for
"already shipped via squash-merge" and caught 142 of 170. It missed 27 more that had, in fact,
already shipped, because GitHub's squash-merge commit message is frequently the **PR title**
(auto-generated from the branch name or set by hand), not a reuse of any individual commit subject
from the branch. A branch titled `feat/onboarding-autosave-and-coverage` whose last real commit says
"coverage is one choice of three, not five equal buttons" ships as a main commit literally titled
"Feat/onboarding autosave and coverage (#537)", which no string match against the branch's own
commits will ever catch.

**Why it matters:** trusting the first pass would have wrongly told the user 5 real feature branches
and 3 real DB-migration branches "need a human decision" or "need Serafim to check if applied", when
all 8 had already landed. One was wrongly flagged as "would regress main if merged" (a real scare)
purely because an old branch's stale diff was compared against today's main without recognising the
branch had already been squash-merged once.

**How to apply:** when auditing whether an unmerged branch's work already shipped, don't stop at
exact commit-subject matching. Cross-check by (1) `git log origin/main -1 -- <file>` for every file
the branch touches, looking for a later commit whose *content*, not just presence, matches, and
(2) diffing the branch's own version of a touched file against main's current version
(`git diff origin/main origin/<branch> -- <file>`), an empty diff is the strongest possible "already
shipped" signal. File-touch recency alone is too noisy (shared files like `CHANGELOG.md` or
`serafim-pending.md` get touched by every session for unrelated reasons), content-diff-empty is not.
