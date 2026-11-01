---
name: feedback-open-merge-link-in-browser-pane
description: "After every push, open the pull/new merge link in the built-in browser pane; she presses Create and merges herself"
metadata:
  node_type: memory
  type: feedback
  originSessionId: be8824f7-307d-4d7d-8a71-6bb70a80f1df
  modified: 2026-10-30T10:12:48.092Z
---

After pushing a branch, open its `…/pull/new/<branch>` link in the built-in browser pane (mcp__Claude_Browser__navigate) straight away, as well as giving the link in the close. Several pushes in one turn: open each in its own tab (tabs_create + navigate).

**Why:** Charlotte 10-30: "can you make the merge links open by default in this panel?" GitHub showed a bot check in the pane once earlier that day, then worked once she was signed in.

**How to apply:** never press Create pull request or Merge yourself; that stays hers. If GitHub shows the bot check again, say so in one line and give the link for her normal browser. Pairs with [[feedback_always_give_merge_link]].
