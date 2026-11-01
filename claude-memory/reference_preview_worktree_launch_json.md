---
name: reference-preview-worktree-launch-json
description: Browser-pane preview of a Hub worktree needs a launch.json at ~/Code/BLC/.claude with npm --prefix; local sign-in is lost with the tab
metadata:
  node_type: memory
  type: reference
  originSessionId: 7723f002-ace0-467b-9735-13a8733d6777
  modified: 2026-10-31T19:54:40.767Z
---

preview_start reads `/Users/personal/Code/BLC/.claude/launch.json` (the session root), not the worktree's own `.claude/launch.json`. To run a worktree's Hub: an entry with `"runtimeExecutable": "npm"`, `"runtimeArgs": ["--prefix", "<worktree path>", "run", "dev", "--", "--port", "5179", "--strictPort"]` (an odd port so other sessions' 5173 is left alone). That file exists from 10-31 pointing at `wt-1031-targeting`; edit the path rather than adding entries.

The local Hub (localhost) needs Charlotte's sign-in, and it was gone once the preview tab closed (10-31). After a merge it's often quicker to check the live Hub (internal.installrhub.com) in the pane, where she stays signed in; see [[feedback-browser-pane-blocks-typing-mid-turn]] and [[feedback-her-tab-runs-old-code-after-merge]].
