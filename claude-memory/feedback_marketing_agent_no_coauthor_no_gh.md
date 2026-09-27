---
name: marketing-agent-no-coauthor-no-gh
description: "marketing-agent repo bans Co-Authored-By trailers and gh CLI use, discovered mid-session after violating both"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 097ece24-1e37-4553-9e99-3718b28ecdfd
  modified: 2026-08-21T07:57:45.281Z
---

In `marketing-hub/marketing-agent`, CLAUDE.md's Git conventions section (only visible once actually working inside that directory, not from BLC's top level) states two rules that are easy to violate before ever reading them:

1. **Never include a `Co-Authored-By` trailer in commits.** Reason given: "Vercel Hobby/Pro blocks deploys when it can't associate a committer with a GitHub user." Each dev commits as their own attributable identity only.
2. **Never use the `gh` CLI in this repo, never run `gh auth switch`.** This machine has two GitHub accounts (BLC `blc-charlieharris-gh` + a separate personal `charlotteharris126` with its own Claude project), and `gh`'s active account is device-global, not per-repo. To open a PR: `git push`, then open the printed `.../pull/new/<branch>` URL in a browser.

Violated both on 2026-08-21 (PR #652's commit had a Co-Authored-By trailer, opened via `gh pr create`) before spotting the rule. Nothing broke this run, PR merged fine, but the timing lines up with an unrelated-looking Vercel failure that session ("Git author ... must have access to a *different* Vercel team than the one that normally works") — plausible the stray co-author trailer is what confuses Vercel's committer-matching, though not confirmed.

**Why:** this is a durable, repo-specific rule from the project's own CLAUDE.md, not a one-off ask — it applies to every future commit in this repo, and there's no way to know it without actually reading that file inside the repo directory (it isn't visible from the parent `marketing-hub/` or `BLC/` level).
**How to apply:** in `marketing-agent`, always commit without a Co-Authored-By line, and use `git push` + the printed PR URL instead of `gh pr create`/`gh pr checks`/etc. Re-read CLAUDE.md fresh at the start of any session touching this repo, since these rules don't surface via memory or general instinct.
