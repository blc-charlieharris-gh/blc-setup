---
name: reference-blc-shared-agent-skills
description: "prime-project and handoff live at ~/code/shared-agent-skills, symlinked into ~/.claude/skills and ~/.agents/skills; edit there only"
metadata:
  node_type: reference
  type: reference
---

The single source of truth for the shared skills is **`/Users/charlotteharris/code/shared-agent-skills/skills/`**,
symlinked into `~/.claude/skills/` (Claude) and `~/.agents/skills/` (Codex and others). Edit there,
nowhere else. Built in house 2026-09-23, replacing nine drifting copies.

- `prime-project` is **read-only**: reads context, reports, stops. No writes, no network.
- `handoff` writes **local files only**. It never commits, pushes, merges, opens a PR or deploys.
  Those are the operator's separate decisions.

`marketing-agent/.claude/skills/` still has its own `prime-project` and `handoff`, which override
the shared ones inside that repo. Deliberately untouched, it is Serafim's repo. Its handoff
hardcodes a Windows path (`C:\Users\seraf\...`) as "the one shared memory store" and runs
`git push` + `gh pr create` + `gh pr merge --squash` unconditionally. Note written for him at
`code/BLC/docs/serafim-note-2026-09-23-handoff-skill.md`, not yet sent.

`find-skills` (from a third-party repo) was removed everywhere except Serafim's copy. Its job was
to run `npx skills add ... -y`, installing third-party skills with confirmation skipped.
**Charlotte's standing preference: rebuild third-party skills in house rather than installing them.**
Related: [[project_blc_moved_out_of_icloud]]
