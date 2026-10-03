---
name: prime-project
description: Load full project context at the start of a session so no manual re-explanation is needed
---

Read-only. This skill gathers context and reports it. It must not edit, create, delete,
commit, push, deploy, or call any external service. The one exception is `git fetch`, which only
downloads what is on GitHub and changes nothing locally: always run it first so the report reads
the latest code (Charlotte, 2026-10-03). The other exception is one short message to each other
Claude session running on this machine (step 2b), so sessions sharing work agree who writes what.
If a step needs something that is not present, skip it silently.

## 0. Project extension

If the project root has its own `.claude/skills/prime-project/SKILL.md` (or names an extension
skill in `CLAUDE.md`), that version adds project-specific steps. Run its extra steps too, under
this skill's read-only rule: if a project step asks for a write (for example marking notes as
read), report what it would write and leave it to the operator.

## 1. Read, in this order

1. `CLAUDE.md` and/or `AGENTS.md` at the project root. Stack, architecture, working conventions.
2. The handoff: `docs/current-handoff.md` or `.claude/docs/current-handoff.md`.
3. The active plan: `docs/current-plan.md` or `.claude/docs/current-plan.md`.
4. Known issues: `docs/known-issues.md` or `.claude/docs/known-issues.md`.
5. The changelog: `docs/CHANGELOG.md` or `.claude/docs/CHANGELOG.md`. Top two or three entries only.
6. The project's main entry file: `src/App.jsx`, `src/main.ts`, `app/layout.tsx`, or the single
   file the project is built around.
7. `git log --oneline -15`.

**When a file exists in both `docs/` and `.claude/docs/`, read the most recently modified one**
and report the other as a stale duplicate. Never trust a handoff just because it was found first.

**Check the plan is still live.** If its steps already show in the code or git log, report
"plan looks complete, clear it at handoff" instead of presenting it as active.

## 2. Tree and sessions (local reads only)

- `git branch --show-current`, `git status --porcelain`, `git stash list`, `git worktree list`.
- `git fetch -q` first, then drift against the remote: `git rev-list --left-right --count HEAD...origin/<default>`.
  If the fetch fails (offline, auth), say so and give the age of the last fetch (`.git/FETCH_HEAD`).
- Commits on no remote branch: `git log --branches --not --remotes --oneline | head`.
- Files modified in the last 3 hours (`find . -newermt '-3 hours' -type f`, excluding `.git`,
  `node_modules` and build output). These mean a live or recent session shares the tree.
- If the harness can list other agent sessions (e.g. ListAgents), list those on this machine and the
  folder each is in. If it cannot, say "other sessions: unknown", never "none".

## 2b. Other sessions: introduce yourself (Charlotte, 2026-10-03)

Charlotte sometimes runs two or three sessions at once (e.g. the Hub, a site, Meta sync). She should
never have to say "speak to the other sessions": do it automatically whenever step 2 finds any.
Send each one ONE short message (SendMessage, copying its name/address):
- the repo folder and branch you are in, and that you have only read so far;
- ask for theirs, and whether they hold any local branches, worktrees or uncommitted files;
- the house rules: each session works on its own branch or worktree if two share a repo; ONE
  session writes each repo's handoff, CHANGELOG top entry, plan and known-issues (the others send
  it a short summary to fold in); whoever writes a handoff messages the others first; before
  ending, each session confirms its branches are merged or handed over and its tree is clean.
Reply to their answers as they arrive during the session. No other sessions: say so in one line.

## 3. Report

- **Current state**: one sentence from the handoff, or "No handoff, fresh start".
- **Active plan**: goal and step, "None", or "complete, clear it".
- **Branch**: current branch, ahead/behind the remote as of the last fetch.
- **Tree and sessions**: "Clean", or each finding (uncommitted files, stash, extra worktrees,
  unpushed commits, recently modified files). These are blockers to raise before starting work,
  not footnotes.
- **Other sessions**: who is running, in which folder, and that you've messaged them (step 2b).
- **Relevant files**: the three to five most likely to be touched, from the handoff's next steps.
- **Risks**: open decisions or flagged assumptions from the handoff.
- **Open issues**: count, flagging any HIGH or MEDIUM by name.
- **Stale docs**: duplicate or out-of-date handoff/plan files from step 1.

Keep the report under roughly 250 words. Omit any section with nothing in it.

Write it for Charlotte, not for a developer (her feedback 2026-10-03: "dont know what you're
telling me here"). Every item says in plain words what it is, who it affects and whether she
needs to do anything. No bare issue titles, no tool names (fetch, RLS, cross_agent_notes)
without saying what they mean in practice. Don't list steps you skipped: do the safe read-only
ones, or leave the line out.

## 4. Then stop

Do not start work. Wait for a task.
