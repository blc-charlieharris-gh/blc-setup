# Plan: nothing in BLC depends on one device (made 30 Oct 2026)

Status: **waiting on Charlotte to check on both devices and approve.** Nothing moved or deleted yet.
Goal: if either the iMac or the MacBook Air died, the other carries on with nothing lost. Clear out what isn't needed.

The list below was checked on the **MacBook Air** only. On the **iMac**, ask Claude to "check the device clean-up plan
on this machine": same read-only checks, add anything that differs under "iMac" at the bottom.

## What was checked on the MacBook Air (read-only)

- Every git repo is fetched, with 0 stashes and 0 unpushed commits on any branch: blc-setup, site-greentide,
  meta-access, installrhub-static, creative-library, marketing-agent.
- No crontab, no BLC launchd jobs.
- Per-machine on purpose (stay as they are): Supabase token in the keychain (`blc-supabase`), Vercel login,
  Claude's Supabase tool token. The README "Setting up a new machine" covers making each one.
- Tools (Node, Python, sharp, deno via npx) install from the README or fetch themselves.

## Move (only on the MacBook Air today)

1. `~/code/BLC/.claude/skills/meta-clone-campaign/` is a real folder, not in any repo. Move into
   `blc-setup/shared-agent-skills/skills/` and link it back, so both devices get it.
2. Key files: `BLC/.env.local`, `marketing-agent/.env`, `marketing-agent/.env.local`, `meta-access/.env`.
   Charlotte copies each real secret into the password manager herself (never git, never chat). The files stay as
   working copies on each machine. `VERCEL_*` lines come from Vercel and can be pulled again anywhere.
   Secrets to save: Anthropic, OpenRouter, Firecrawl, Resend, Meta (access + page token, ad account ids),
   Supabase service key, GitHub token, Hub password + session key, Web3Forms key.
3. New memory files not yet pushed in blc-setup: `blc-sync push`.

## Keep

4. All repos above (on GitHub).
5. Worktrees `ma-blog-question` and `marketing-agent/.claude/worktrees/wt-fixes-1030`: clean and pushed, may belong
   to running sessions; the daily clean-up clears them.
6. `helix-power-site-2026-10-30/` + `helix-power-ai-kit-2026-10-30.zip` (another session using them).
7. Small per-machine settings: `.claude/settings.local.json`, `.vscode`, `.agents`, `.last-cleanup`, skill links.
8. The 53 local Hub branches: all still on GitHub; the daily clean-up handles them.

## Delete (one zsh script for Charlotte, once approved)

9. `_deploy`: everything older than the day of the clean-up (paste files are rebuilt before every paste),
   including `harvard-renewables-mockup.zip`.
10. Two loose webinar deck exports in `site-installrhub/` (2-3 Oct, 18MB). Current deck rebuilds from
    `installrhub-static/webinar-deck/build.py`. Or: put them in Google Drive instead.
11. Empty `site-installrhub/deck/`.
12. `marketing-hub/vt.log` (old test log from a worktree that's gone).
13. Loose screenshots in BLC root, `.DS_Store` files.
14. `meta-access/outputs` (2.8MB scratch from the J&B clone, AS05 fix, Elect site score; scripts are in git).

## iMac

(not checked yet)
