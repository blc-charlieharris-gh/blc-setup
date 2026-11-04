---
name: feedback_clipboard_shared_between_sessions
description: "Sessions share one clipboard; a paste file can be overwritten before Charlotte pastes. Recopy right before, verify the deployed fn after; build from latest main"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0b5481e2-5705-450f-8a6e-b3ef2173efd1
  modified: 2026-11-04T18:46:09.423Z
---

On 11-04 broadcasts code went live as nurture-run v91 (and another session hit the reverse, broadcasts v99 with nurture-run code): another session's pbcopy replaced the clipboard between my copy and Charlotte's paste. A paste file built from a feature branch also nearly reverted other sessions' merged changes.

**Why:** every Claude session on the Mac shares one clipboard, and main moves fast with several sessions merging.

**How to apply:** build `_deploy/<fn>.ts` from a checkout at the latest origin/main (not a feature branch); copy it in the same message as opening the editor; after she deploys, always read the live fn (get_edge_function) and check a marker unique to that fn (e.g. `startDatedEarly` for nurture-run, `listRows` for broadcasts), not just the new code. Check the clipboard with `LANG=en_US.UTF-8 pbpaste | cmp - file`. Related: [[feedback_pbcopy_needs_utf8]], [[feedback_rebuild_deploy_files_before_paste]].
