---
name: feedback_cleanup_scripts_rm_rf_and_tracked_dsstore
description: "Delete scripts for Charlotte use rm -rf on named paths (rm -r hangs on git's read-only files); installrhub-static tracks .DS_Store"
metadata:
  node_type: memory
  type: feedback
  originSessionId: bbb301a5-e3e9-4735-b7f3-a9769f450402
  modified: 2026-11-01T16:12:21.242Z
---

In zsh scripts I hand Charlotte, delete named folders with `rm -rf -- "<path>"`, never `rm -r`: on a git folder `rm -r` stops at "override r--r--r--?" for read-only pack files and waits; she can't tell it's waiting, and a half-deleted repo then looks like "unsaved work" (1 Nov 2026, site-greentide). Before sweeping `.DS_Store` files, check `git ls-files` for them: installrhub-static tracks two, and the sweep left that repo dirty until restored.

**Why:** the stuck run cost three back-and-forths and she couldn't close it herself ("no idea how to do that"); my `kill` was refused, so stopping it had to go in her next script.

**How to apply:** `rm -rf` only on exact named paths, re-check git state inside the script before deleting a repo, skip git-tracked files in any pattern sweep. Related: [[feedback_daily_cleanup_at_handoff]], [[reference_blocked_actions_give_command]].
