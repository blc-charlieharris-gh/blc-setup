# Note for Serafim, 2026-09-23: two problems in `.claude/skills/handoff/SKILL.md`

Found while auditing skills across the BLC projects. Not changed, since it is your repo.
Both are in `marketing-agent/.claude/skills/handoff/SKILL.md`.

## 1. The memory path is a Windows path on your machine

Under "Also save troubleshooting lessons to memory", the skill names this as the one shared store:

```
C:\Users\seraf\.claude\projects\c--Users-seraf-AI-Workspace-10-Active-Projects-Marketing-Agent\memory\
```

and adds "Do not move or rename it."

That path does not exist on the Mac. Any agent running this skill here either fails the step
or creates that literal string as a folder name. The intent is right, one shared store beats
per-tool private memory, but a hardcoded absolute path cannot be the mechanism across two
machines and two operating systems.

Suggestion: point at a path inside the repo (for example `.claude/memory/`) so it resolves for
both of us and travels with the code, or drop the specific path and say "the memory directory
your agent already uses".

## 2. The skill pushes and self-merges without asking

The closing section runs, unconditionally:

- `git push -u origin HEAD`
- `gh pr create --base main --fill`
- `gh pr merge --squash` for anything classified Tier-1

So ending a session opens and merges a PR against `marketing-agent` with no confirmation step.
It also inserts rows into `public.cross_agent_notes` on the shared production database.

Two consequences worth weighing:

- An agent that misjudges Tier-1 versus Tier-2 self-merges a migration or edge-fn change into
  the shared prod DB.
- Anyone running the skill from a checkout of your repo pushes under their own credentials.

Suggestion: keep the commit, make the push and the PR an explicit step the operator asks for.

## 3. Minor: it mandates `gh`, which conflicts with a rule we have written down

Our notes for this repo say not to use the `gh` CLI. The skill requires it. One of the two is
stale. Worth settling which.

## What I changed on our side

Nothing in your repo. BLC's other projects now share a single `prime-project` and `handoff`
from `~/Code/shared-agent-skills`, rebuilt so that `prime-project` is read-only and `handoff`
never commits, pushes, merges or deploys. Yours is untouched and still overrides ours inside
`marketing-agent`, which is fine if that is what you want.
