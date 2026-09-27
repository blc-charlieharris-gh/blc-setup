# blc-setup (private)

Charlotte's personal working setup, so the Mac and the laptop stay the same. Only personal / cross-project
things live here. Project work lives in its own repo (the Hub in `marketing-agent`, sites in their repos)
and is saved through PRs as usual.

| Folder | What | Where the machine sees it |
|---|---|---|
| `claude-memory/` | Claude's memory for the BLC project (how Charlotte works, what we've learned) | `~/.claude/projects/-Users-<you>-code-BLC/memory` (link) |
| `shared-agent-skills/` | prime-project and handoff skills | `~/code/shared-agent-skills`, `~/.claude/skills`, `~/.agents/skills` (links) |
| `blc-notes/` | BLC-wide notes (CHANGELOG, SERVICES, CAC reports, lead routing, notes for Serafim) | `~/code/BLC/docs` (link) |
| `bin/` | `blc-sync` and `blc-setup-machine` | run directly |

**Never here:** key files (`.env`, `.env.local`), `.vercel` links, customer contact exports. `.gitignore` blocks them.

## Switching devices

Leaving a device:
1. Tell Claude "switching devices". It finishes or parks the open work, writes the handoff, gets everything
   merged and pushed, and makes sure no other session is running.
2. `~/code/blc-setup/bin/blc-sync status` shows every repo; everything should read 0.
3. `~/code/blc-setup/bin/blc-sync push` saves memory / skills / notes to GitHub.

Arriving on a device:
1. `~/code/blc-setup/bin/blc-sync pull` updates every repo from GitHub.
2. Open Claude in `~/code/BLC` and say "prime project".

One device at a time.

## Setting up a new machine (once)

1. Install: Homebrew, git, Node (LTS), Antigravity with the Claude Code extension. Log in to Claude. Run the commands below in Antigravity's terminal (Terminal > New Terminal).
2. GitHub: sign in as `blc-charlieharris-gh` (Serafim's `marketing-agent` repo already lets this account in).
3. `mkdir -p ~/code && git clone https://github.com/blc-charlieharris-gh/blc-setup.git ~/code/blc-setup`
4. `~/code/blc-setup/bin/blc-setup-machine` (clones every repo into the same folders as the Mac and links memory, skills, notes).
5. Copy the key files from the Mac (AirDrop the `blc-keys` bundle, then delete it on both machines):
   - `~/code/BLC/marketing-hub/marketing-agent/.env` and `.env.local`
   - `~/code/BLC/meta-access/.env`
   - `~/code/BLC/.env.local`
   - the `.vercel` folders (site deploy links) in the same places
6. `cd ~/code/BLC/marketing-hub/marketing-agent && npm install`
7. Vercel CLI (for site deploys): `npm i -g vercel && vercel login` (team scope blc-promotions).
8. Claude's Supabase connector follows your Claude account; check it shows as connected.
9. In Antigravity: File > Open Folder > `~/code/BLC`, open Claude in the sidebar and say "prime project".
