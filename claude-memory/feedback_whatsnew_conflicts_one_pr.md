---
name: feedback-whatsnew-conflicts-one-pr
description: Several open Hub PRs each adding a top whatsNew.js line conflict after every merge; bundle same-day PRs into one or stack them
metadata:
  type: feedback
---

2026-10-05: four open marketing-agent PRs each added an entry at the top of src/lib/whatsNew.js, so every merge made the rest conflict and Charlotte kept hitting "This branch has conflicts". Fixed by rebasing all of them into ONE combined PR (she merged #1497 once).

**Why:** the same insertion point in one file; squash merges don't let stacked branches merge cleanly either.
**How to apply:** when more than one Hub PR is waiting on her, combine them into one branch (or keep at most one open with a whatsNew line), and re-check `git merge-tree --write-tree origin/main origin/<branch>` before telling her it's ready. Related: [[feedback_merge_checklist_file]].
