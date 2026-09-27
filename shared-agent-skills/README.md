# Shared agent skills

The single source of truth for the skills used across BLC projects, by Claude and Codex alike.

- `skills/prime-project` — start of session. Read-only, reports context, then stops.
- `skills/handoff`: end of session. First inspects working trees, other sessions and drift, and
  stops for the operator if anything needs a decision. Writes local files only. Never commits,
  pushes, or deploys.

Edit here, nowhere else. Every other location is a link back to this folder.

## Exposed at

- Claude: `~/.claude/skills/<name>` → symlink to `skills/<name>`
- Codex and other agents: `~/.agents/skills/<name>` → symlink to `skills/<name>`

## Rules

1. These two skills stay generic. Anything project-specific belongs in that project's own
   extension skill, named differently, not in a fork of these.
2. `prime-project` is read-only. It must never write, commit, or call an external service.
3. `handoff` writes local files only. Committing, pushing and deploying are the operator's
   decisions, taken separately.
4. Never hardcode a machine path. Nothing here should mention a home directory.
5. No third-party skill gets installed without reading it first, in full.
