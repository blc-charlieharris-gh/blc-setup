---
name: reference_device_switching_blc_setup
description: Mac + laptop via private blc-setup repo; blc-sync pull/push; BLC-only GitHub/Vercel logins on the laptop (blc-accounts, blc-vercel)
metadata:
  type: reference
---

Charlotte works on a Mac and a laptop (Antigravity + Claude Code extension on both), one at a time. Set up 2026-09-27.

- `~/code/blc-setup` (private, blc-charlieharris-gh) holds claude-memory, shared-agent-skills, blc-notes (linked as ~/code/BLC/docs, CHANGELOG.md, SERVICES.md) and bin/. Project work (the Hub audit tracker included, `.claude/docs/hub-audit/`) lives in its own repo and moves by PR.
- Leaving a machine: finish/park work, get PRs merged, then `~/code/blc-setup/bin/blc-sync status` (all 0) and `blc-sync push`. Arriving: `blc-sync pull`, then "prime project".
- Laptop has other GitHub/Vercel/Supabase/Netlify accounts for other projects (home folder `/Users/personal`, gh active account pulset-gh). BLC git sign-in is scoped by repo owner via `bin/blc-accounts` (includeIf hasconfig -> git/gitconfig-blc, `gh auth token --user blc-charlieharris-gh`). Never run `gh auth setup-git` or `gh auth switch` there without switching back. On the laptop deploy BLC sites with `~/code/blc-setup/bin/blc-vercel` (own config dir), never plain `vercel`. The Mac still uses plain gh setup-git + vercel as BLC.
- Key files never go in git: moved once by AirDrop zip, then deleted.
