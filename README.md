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

Accounts stay per project: BLC's GitHub and Vercel logins apply to BLC folders only, other projects keep theirs.

1. Install: Homebrew, git, Node (LTS), Antigravity with the Claude Code extension. Log in to Claude. Run the commands below in Antigravity's terminal (Terminal > New Terminal).
2. GitHub, BLC only: `brew install gh`, then `gh auth login` and sign in as `blc-charlieharris-gh` (adding it next to other accounts is fine). Do NOT run `gh auth setup-git`: it makes one account sign in for every project.
3. `mkdir -p ~/code && git -c credential.helper= -c include.path=$HOME/code/blc-setup/git/gitconfig-blc clone https://github.com/blc-charlieharris-gh/blc-setup.git ~/code/blc-setup` (if that fails because the include file is not there yet, see "first clone" below)
4. `~/code/blc-setup/bin/blc-accounts` (BLC-only GitHub sign-in and commit name, matched on the repo owner)
5. `~/code/blc-setup/bin/blc-setup-machine` (clones every repo into the same folders as the Mac and links memory, skills, notes).
6. Copy the key files from the Mac (AirDrop the `blc-keys` bundle, unzip inside `~/code/BLC`, then delete it on both machines).
7. `cd ~/code/BLC/marketing-hub/marketing-agent && npm install`
8. Vercel, BLC only: `npm i -g vercel`, then `~/code/blc-setup/bin/blc-vercel login` (team blc-promotions). Always deploy BLC sites with `blc-vercel`, never plain `vercel`, so other Vercel/Netlify logins are untouched.
9. Supabase: nothing to log in on the machine. BLC migrations are pasted in the Supabase website, and Claude's Supabase connector follows the Claude account; check it shows as connected.
10. In Antigravity: File > Open Folder > `~/code/BLC`, open Claude in the sidebar and say "prime project".

**First clone:** the include file lives inside blc-setup itself, so for the very first clone use gh directly:
`GH_TOKEN=$(gh auth token --user blc-charlieharris-gh) gh repo clone blc-charlieharris-gh/blc-setup ~/code/blc-setup -- -c credential.helper=`
then carry on from step 4.
