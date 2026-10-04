---
name: feedback_no_commits_after_ready_to_merge
description: Once Charlotte is told a PR is ready to merge, never push more commits to it; open a new PR instead
metadata:
  type: feedback
---

Once a PR is on Charlotte's "merge these" list, treat it as frozen. Put later changes in a new PR.

**Why:** 2026-10-03, site-installrhub: I pushed the /book-demo → /thank-you change to #115 after telling her to merge it. She had already merged, so the change was left out and needed follow-up #116. She also lost track of what she had merged.

**How to apply:** before adding to an existing PR, check `gh pr view N --json state`. If she has been told it's ready, branch fresh and give her the new number in one ordered list. Related: [[feedback_coordinate_other_sessions_automatically]], [[feedback_merge_checklist_file]]
