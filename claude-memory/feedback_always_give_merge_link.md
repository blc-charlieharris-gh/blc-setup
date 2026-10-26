---
name: feedback_always_give_merge_link
description: "Anything for main (PRs AND the handoff/docs) ends with its merge link; never leave files for her to commit"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 862a8d37-73ba-4964-9ede-bf32cd0b4fc6
  modified: 2026-10-15T13:50:15.278Z
---

Every time a PR is ready, give Charlotte the GitHub PR link to merge, alongside the preview link.

**Why:** 10-15 she said "merged" but couldn't, because I had only said the PR was ready. She then had to ask: "you didn't give me a merge".

**How to apply:** at the end of any build, include `Merge: <PR url>` and `Preview: <branch preview url>/<page path>`. If she says "merged" and GitHub still shows it as open, merge it yourself with `gh pr merge --squash`, since that's what she wants. Related: [[feedback_handoff_includes_commit_and_merge]]

**Handoff too (10-26):** the handoff skill writes local files only, and I closed with "commit these yourself" and no link. She said: "why do you not give me link as standard? i could miss that easily and just close down". So the handoff, CHANGELOG, known-issues and memory edits always go on a docs branch off origin/main, get pushed, and the close leads with that link. Never end a session with uncommitted docs and no link.
