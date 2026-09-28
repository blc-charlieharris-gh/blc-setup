# blc-setup (private)

Charlotte's personal working setup, so the Mac and the laptop stay the same. Only personal / cross-project
things live here. Project work lives in its own repo (the Hub in `marketing-agent`, sites in their repos)
and is saved through PRs as usual.

| Folder | What | Where the machine sees it |
|---|---|---|
| `claude-memory/` | Claude's memory for the BLC project (how Charlotte works, what we've learned) | `~/.claude/projects/-Users-<you>-code-BLC/memory` (link) |
| `shared-agent-skills/` | BLC's prime-project, handoff, switch-devices | prime-project + handoff linked only in `~/code/BLC` and this repo (`.claude/skills`, `.agents/skills`); switch-devices machine-wide. Other projects use the generic `~/code/shared-agent-skills` (Mac only). `bin/blc-link-skills` sets it up. |
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
3. First clone, signed in as the BLC account for this one command only:
   `mkdir -p ~/code && git -c credential.helper= -c 'credential.helper=!f() { echo username=blc-charlieharris-gh; echo password=$(gh auth token --user blc-charlieharris-gh); }; f' clone https://github.com/blc-charlieharris-gh/blc-setup.git ~/code/blc-setup`
4. `~/code/blc-setup/bin/blc-accounts` (BLC-only GitHub sign-in and commit name, matched on the repo owner)
5. `~/code/blc-setup/bin/blc-setup-machine` (clones every repo into the same folders as the Mac and links memory, skills, notes).
6. Copy the key files from the Mac (AirDrop the `blc-keys` bundle, unzip inside `~/code/BLC`, then delete it on both machines).
7. `cd ~/code/BLC/marketing-hub/marketing-agent && npm install`
8. Vercel, BLC only: `npm i -g vercel`, then `~/code/blc-setup/bin/blc-vercel login` (team blc-promotions). Always deploy BLC sites with `blc-vercel`, never plain `vercel`, so other Vercel/Netlify logins are untouched.
9. Supabase, BLC only: `brew install supabase/tap/supabase`, then `~/code/blc-setup/bin/blc-supabase set-token` (paste an access token made while signed in to Supabase as BLC). Deploy Hub edge fns with `blc-supabase deploy <fn>`; the token sits in its own keychain entry and is used per command, so the machine's other Supabase login is untouched.
9. Supabase: see "Supabase on a new machine" below (per machine, BLC folder only).
10. In Antigravity: File > Open Folder > `~/code/BLC`, open Claude in the sidebar and say "prime project".

## Supabase on a new machine

Claude's Supabase tool is set per machine, for `~/code/BLC` only, read-only. Each machine gets its own token
(so one can be cancelled without the other). Never copy it between machines or put it in git.
1. In the browser, log in to the BLC Supabase account, then Account > Access Tokens > Generate new token,
   named e.g. "laptop Claude". Copy it.
2. In the terminal:
   `cd ~/code/BLC && claude mcp add supabase --scope local -e SUPABASE_ACCESS_TOKEN=PASTE_TOKEN_HERE -- npx -y @supabase/mcp-server-supabase@latest --read-only --project-ref=ozmyjrzleejbqxqphbut`
   (if `claude` is not found, ask Claude in Antigravity to run it for you, pasting the token only into that command).
3. Restart Claude in Antigravity; the Supabase tools should appear.
