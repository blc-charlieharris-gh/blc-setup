---
name: reference_blocked_actions_give_command
description: The safety check blocks Claude's git branch deletes and production deploys here; give Charlotte the exact command instead
metadata:
  type: reference
---

On this Mac the auto-mode check refuses `git branch -D` / `git push --delete` and `blc-vercel deploy --prod` (2026-10-28/29). Don't retry or work around it: write the exact command (or a script naming exact branches) and give it to Charlotte to run. Running a script from the scratchpad needs `zsh <path>` (a direct path silently did nothing once).
