---
name: prime-project
description: Load full project context at the start of a session so no manual re-explanation is needed
---

Read-only. This skill gathers context and reports it. It must not edit, create, delete,
commit, push, fetch, deploy, or call any external service. If a step needs something that is
not present, skip it silently.

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
- Drift against the last-fetched remote: `git rev-list --left-right --count HEAD...origin/<default>`.
  Give the age of that comparison (modification time of `.git/FETCH_HEAD`). Do not fetch.
- Commits on no remote branch: `git log --branches --not --remotes --oneline | head`.
- Files modified in the last 3 hours (`find . -newermt '-3 hours' -type f`, excluding `.git`,
  `node_modules` and build output). These mean a live or recent session shares the tree.
- If the harness can list other agent sessions, list those on this machine and the folder each
  is in. If it cannot, say "other sessions: unknown", never "none".

## 3. Report

- **Current state**: one sentence from the handoff, or "No handoff, fresh start".
- **Active plan**: goal and step, "None", or "complete, clear it".
- **Branch**: current branch, ahead/behind the remote as of the last fetch.
- **Tree and sessions**: "Clean", or each finding (uncommitted files, stash, extra worktrees,
  unpushed commits, recently modified files, other sessions). These are blockers to raise
  before starting work, not footnotes.
- **Relevant files**: the three to five most likely to be touched, from the handoff's next steps.
- **Risks**: open decisions or flagged assumptions from the handoff.
- **Open issues**: count, flagging any HIGH or MEDIUM by name.
- **Stale docs**: duplicate or out-of-date handoff/plan files from step 1.

Keep the report under roughly 250 words. Omit any section with nothing in it.

## 4. Then stop

Do not start work. Wait for a task.
