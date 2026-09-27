---
name: project-blc-moved-out-of-icloud
description: "BLC moved from Documents/BLC (iCloud) to ~/code/BLC on 2026-09-23; old copy kept as rollback until ~2026-10-07"
metadata:
  node_type: project
  type: project
---

**The BLC project now lives at `/Users/charlotteharris/code/BLC`** (lowercase `code`). Moved
2026-09-23 from `/Users/charlotteharris/Documents/BLC`, which WAS inside the iCloud container
(same inode as `~/Library/Mobile Documents/com~apple~CloudDocs/Documents/BLC`, Desktop &
Documents sync on). That sync is the confirmed cause of the years-long git corruption in
[[project_blc_workdir_corruption]].

Copied with `rsync -aH`, excluding `node_modules`, `website-factory/scratchpad` (2.3 GB of
throwaway Chrome profiles and screenshots, nothing since 2026-08-14) and iCloud `" 2"` conflict
files. 4.8 GB became 2.5 GB. Verified: file-by-file diff, 792 tests pass, vite build clean.

**The old copy at `Documents/BLC` is UNTOUCHED and is the rollback.** Do not delete before
roughly 2026-10-07, and not before a confirmed separate backup exists (there is still no Time
Machine destination on this machine).

Fixed during the move, worth not re-breaking:
- `site-greentide/scripts/verify-split-test.js` now resolves its path relative to the script
  instead of a hardcoded home path.
- The LocalWP theme symlink under `site-installrhub/installrhubsite/.../themes/` was broken
  since June (pointed at the renamed `InstallrHub/` folder). Now relative.
- A corrupt loose git object `788c7de` survives in `marketing-agent`. Pre-existing, cosmetic,
  the branch and its 757-commit history resolve fine and GitHub has a good copy.

**Why:** two copies exist during the observation period, so it matters which one is being edited.
**How to apply:** work in `~/code/BLC`. If anything looks wrong, `Documents/BLC` is intact.
Related: [[reference_blc_shared_agent_skills]]
