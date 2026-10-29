---
name: handoff
description: Write an end-of-session handoff so the next session can resume without re-explanation
---

Writes local files only. This skill must never commit, push, merge, open a pull request,
change branches, deploy, publish, delete files, or write to any external system. It sends
nothing either, with one exception: a short note to another session running on the same
machine, and only when the operator picks that option in step 0.
If the project wants work committed or pushed at the end of a session, the operator asks
for that separately, as its own decision.

## 0. Inspect first, then stop

Before writing anything, check the state the handoff is about to describe. This step only
reads. Use `git ls-remote` to compare with the remote, not `git fetch`. Check every repo the
session touched. If the project spans several repos under one workspace, check all of them.

**a. Working tree.** Run `git status --porcelain` and sort every entry into three groups:
- changed by this session
- not changed by this session (another session, or earlier leftover work)
- unsure

Call out untracked folders. Also call out any deletion of a tracked file (` D`) that this
session did not intend: another session may have changed branch underneath you.

**b. Branch and drift.** Report:
- the current branch, and whether it is the default branch
- how far local HEAD is ahead of or behind the remote default branch
- local commits that were never pushed
- anything in `git stash list`
- each entry in `git worktree list`, with the branch it holds

**c. Other active sessions.** If your harness can list other running agent sessions, list the
ones on this machine and the folder each is working in. Coordinate with them automatically,
without being asked (Charlotte, 2026-10-03): one session writes each repo's handoff, CHANGELOG
top entry and known-issues. Before writing, message every session in the same repo: say you
are writing it and ask for a short summary of their work (what changed, PRs, anything open,
things for Charlotte) to fold in as their own section, or agree that they write it instead.
Sessions in other repos just get a heads-up. After writing, tell them it's done. Either way, list files in these repos
modified in the last few hours that this session did not touch. That is the sign of a live
session sharing the tree. If you cannot see other sessions, say so rather than assuming there
are none.

**d. Drift sources.** These are places where what is live, or what the next session will
read, no longer matches git:
- Anything this session deployed, applied or published from uncommitted files: site
  deploys, serverless or edge functions, database migrations, hosted config. Name the
  target, and say that its source exists only on this machine.
- Shared scratch files another session may overwrite or already has: the handoff file, the
  top changelog entry, plan files. Check whether each changed since this session last read it.
- Conflict copies left by a sync service: names ending ` 2`, `(1)`, or `.icloud`.
- Lockfiles or generated files that changed without the session meaning them to.
- A memory index approaching its size limit.

**Report and wait.** Show one short table with the columns Finding, Whose, Risk and
Suggested action. Each action is one of:
- fix now (only the specific fix the operator approves)
- commit separately (the operator's own decision, outside this skill)
- pass a note to another session
- leave as is

Then stop, and wait for the operator before going on to step 1. If everything is clean, say
so in one line and carry on without stopping.

To pass a note, use your harness's session messaging if it has one. Send one short message
naming the file and the risk. If it has none, write the note in the handoff under
"Working tree and other sessions".

## 1. Write the handoff

To `docs/current-handoff.md`, or `.claude/docs/current-handoff.md` if the project keeps its
docs there. Overwrite the file. Under 250 words. Name real files and functions, not vague
descriptions.

```
# Handoff, YYYY-MM-DD

## What we worked on
- [bullet]

## Current state
[done / in progress / broken or incomplete]

## Next steps
1. [highest priority]
2. [next]

## Decisions and open questions
[choices made, or things still pending a decision]

## Working tree and other sessions
[what step 0 found and what the operator decided: left uncommitted, deployed but not
committed, notes for other sessions. One line: "Clean" if nothing was found.]
```

If a plan is active, say how far through it the session got.

## 2. Update the changelog

If `docs/CHANGELOG.md` exists, add an entry at the top, below any intro paragraph. One line
per change, grouped under `###` headings.

```
## YYYY-MM-DD

### [Feature or area]
- [one-line summary]
```

Do not rewrite existing entries. If two sessions could be running at once, check that the
current top entry is still the one you expected before inserting above it.

## 3. Save what you learned to memory

The handoff is session state. Memory is for durable facts about how this system behaves.
Write those as you learn them, not in a batch at the end. This step is the backstop sweep.

Worth saving:
- A bug that took several attempts to diagnose. Save the root cause and the fix.
- A tool or service that behaved unexpectedly. Save the working pattern.
- A constraint or decision not derivable from the code or git history.

Write to the memory directory the agent you are running as already uses. Do not write to
another agent's private memory store, and do not invent a path. If you cannot determine
where memory lives, say so in your closing message rather than skipping it silently.

One fact per file, named `<type>_<short-kebab-slug>.md`:

```markdown
---
name: <short-kebab-case-slug>
description: <one line, used to judge relevance on recall>
metadata:
  type: user | feedback | project | reference
---

<the fact. For feedback and project, add **Why:** and **How to apply:** lines.
Link related memories with [[their-name]].>
```

`feedback` is guidance on how to work, with the reason. `project` is ongoing work or
constraints, with dates written out in full. `reference` points at external resources.
`user` is who the person is.

Then add one line to `MEMORY.md` in the same directory: `- [Title](file.md) — hook`. A fact
file with no index line will not be recalled. Keep index lines under about 200 characters;
they are pointers, not summaries. If `MEMORY.md` is approaching 24 KB it will truncate, so
move the oldest section into a dated archive file beside it and leave a pointer.

Check for an existing file covering the same fact and update it rather than adding a
duplicate. Skip this step entirely if the session held no surprises.

## 3b. Daily clean-up (Charlotte 2026-10-29: "clean data hygiene", nothing piles up)

Once a day on each device (iMac and MacBook Air alike): the first handoff of the day on that device does this,
whichever folder the session is in. Skip it when `~/code/BLC/.last-cleanup` already holds today's date; write today's
date there when done (the file is per device, never synced: each device clears its own leftovers, and GitHub's are
cleared by whichever device gets there first). The point is that both devices, GitHub and the docs only hold what's
still in use. Only remove what is provably finished; anything unclear is listed for Charlotte, never guessed.

Which repos: the `REPOS` list in `~/code/blc-setup/bin/blc-sync` (the one list both devices use) plus
`~/code/blc-setup` itself, plus any other git folder under `~/code/BLC` (`find ~/code/BLC -maxdepth 3 -name .git`),
for example a stray worktree folder like `site-installrhub/.wt-*`. In each:
1. **Local branches** other than the default: `git fetch --prune` first. Safe to remove = its upstream is gone, or it
   is on origin and its last commit is over 2 days old (the PR is merged or the work lives on GitHub). Never remove a
   branch with commits that are on no remote branch (`git log <b> --not --remotes`): list it with what it holds.
2. **Branches on GitHub** over 7 days old whose PR is merged (squash merges: check the PR, or the branch's commit
   message in `origin/main`'s log). List with the command; Charlotte runs it. If "Automatically delete head
   branches" is on in the repo's GitHub settings this list stays empty.
3. **Worktrees**: `git worktree prune`; a worktree that is clean and whose branch is merged is removed.
4. **Stashes** over 7 days old: list each with what it holds; Charlotte says keep or drop.
5. **`~/code/BLC/_deploy`**: paste files and SQL over 7 days old (they're rebuilt for every deploy, never reused).
6. **Scratchpad / temp**: `/private/tmp/claude-$(id -u)/*` folders from sessions over 2 days old.
7. **Docs that stack up** (done by Claude in the handoff commit, no deletes needed): handoff sections older than
   yesterday leave `current-handoff.md` (the CHANGELOG already has them); known-issues Fixed items over 14 days old and
   test-list items marked tried move to their archive files; a memory index over ~200 lines gets its oldest lines
   moved to a dated archive file.

Claude's branch and file deletes are refused on this Mac (memory reference_blocked_actions_give_command), so write
items 1 to 6 as ONE script naming each exact branch and file (`git branch -D <name>`, `git worktree remove <path>`,
`rm <file>`), save it in the scratchpad, and give Charlotte `zsh <path>` with a count per item in plain words
("12 old branches on this Mac, 30 old paste files"). Never `rm -rf` a folder by pattern, never a branch with
unpushed work, never anything another live session is using (check other sessions first, step 0).

## 4. Close

Confirm what was written, in one line per file. Then state plainly what has **not** been
done: nothing was committed, pushed, or deployed by this skill. Repeat any step 0 findings
the operator chose to leave, and anything still uncommitted, so they can decide.

Write the close for Charlotte in plain words (see the prime-project report rule): what is
live, what she needs to merge or run (with links), what's next.

Then check the clean-close list below and report each line as met, or not met with who owns it:
- `git status --porcelain` is empty in every repo the session touched.
- Every branch this session created is merged, or named with what it holds and who merges it.
  A handoff committed to a branch counts: an unmerged handoff is a stale handoff.
- No worktree this session created is left behind (`git worktree list`).
- The local default branch matches the remote (`git ls-remote` against `git rev-parse`).
- Nothing is live (deploys, applied SQL, edge functions) without a commit behind it.
- Known issues touched this session are moved to Fixed, or logged with a severity.
- Other sessions sharing the tree know about anything that affects them.
