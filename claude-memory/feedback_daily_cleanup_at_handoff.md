---
name: feedback_daily_cleanup_at_handoff
description: "First handoff of the day on each device clears old branches, worktrees, stashes, _deploy files, temp folders and stacked docs; one zsh script for Charlotte"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 8d6f699a-972a-4f5d-bacf-2dda0f258db0
  modified: 2026-10-29T08:47:27.367Z
---

Every device (iMac and MacBook Air) runs a daily clean-up at its first handoff of the day: BLC handoff skill step 3b (shared via blc-setup), pointed to from the Hub repo's handoff skill. Stamp file `~/code/BLC/.last-cleanup` is per device. Repos = blc-sync's REPOS list + blc-setup + any other git folder under ~/code/BLC.

**Why:** Charlotte 2026-10-29: 430 local and ~1,700 GitHub branches had piled up because Claude's deletes are blocked; she wants one simple system on both devices, "clean data hygiene".

**How to apply:** deletes go in one script she runs with `zsh <path>` (see [[reference_blocked_actions_give_command]]); only provably finished things; doc trims (handoff, known-issues, test list, memory index) Claude does in the handoff commit.
