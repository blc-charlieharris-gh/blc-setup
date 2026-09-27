---
name: switch-devices
description: Move Charlotte's BLC work between the Mac and the laptop. Use when she says "switching devices", "switching to laptop/Mac", "I'm on the laptop now", or asks how syncing works.
---

Charlotte works on two machines, one at a time, and forgets the routine. Walk her through it in plain
numbered steps, run what you can yourself, and give her exact commands for anything she must run.
Setup details: `~/code/blc-setup/README.md`.

## Leaving this machine ("switching devices")

1. Finish or park the open work. Anything half-done goes on a pushed branch with a PR, or is written up.
2. Run the `handoff` skill (it writes the handoff and checks for other sessions). Get the handoff and any
   open work merged: work on an unmerged branch does not reach the other machine's "prime project".
3. Check no other Claude session on this machine is mid-task (ListAgents); tell it to wrap up.
4. Run `~/code/blc-setup/bin/blc-sync status`. Every line must read `uncommitted 0, unpushed commits 0`.
   Fix anything that doesn't before going on.
5. Run `~/code/blc-setup/bin/blc-sync push` (saves memory, skills, notes).
6. Tell her: "Safe to close. On the other machine: run blc-sync pull, then say prime project."

Key files (`.env`, `.env.local`) and `.vercel` links never go through git. They are already on both
machines; only if a key changes does it need copying again (AirDrop, then delete the copy).

## Arriving on this machine ("I'm on the laptop now")

1. Tell her to run `~/code/blc-setup/bin/blc-sync pull` (or run it yourself). Every repo should say up to date.
2. Run `prime-project`.

## Rules to repeat to her

- One machine at a time. Never have Claude working on both.
- Laptop only: BLC GitHub sign-in is scoped to BLC repos (`bin/blc-accounts`). Never run
  `gh auth setup-git` there, and deploy BLC sites with `~/code/blc-setup/bin/blc-vercel`, not plain `vercel`.
  Her other projects keep their own GitHub, Vercel, Netlify and Supabase accounts.
- Supabase needs no login on the machine: migrations go through the Supabase website, and Claude's
  Supabase connector follows the Claude account (check it shows as connected).

## Quick check it's synced

Write a code word to `~/code/BLC/docs/sync-test.md`, `blc-sync push`, then on the other machine
`blc-sync pull` and ask Claude for the code word.
