---
name: feedback-generic-skill-shadows-blc-skill
description: "Machine-wide ~/.claude/skills prime-project/handoff (generic) beat ~/Code/BLC/.claude/skills copies by name; generic now routes to the folder's own copy. iMac still needs it."
metadata:
  type: feedback
---

On 2026-10-03 the laptop ran the generic prime (no fetch, no session messaging) inside BLC. Cause: a skill installed for the whole machine (~/.claude/skills -> ~/code/shared-agent-skills) beats a project's same-named copy (~/Code/BLC/.claude/skills -> blc-setup BLC versions), so BLC's prime/handoff never loaded.

Fix (Charlotte approved 2026-10-03, laptop only): added a "Use the folder's own version first" section at the top of ~/code/shared-agent-skills/{prime-project,handoff}/SKILL.md, which says to follow the outermost `.claude/skills/<name>/SKILL.md` above the working directory (stopping before home). Other projects have no copy, so nothing changes for them. That folder isn't synced (no remote).

**Why:** Charlotte wants to just say "prime" and get the fetch + session coordination without repeating it.
**How to apply:** on the iMac, check the generic SKILL.md files have that section; if not, add the same text (needs her approval, since it edits skill files). If prime output lacks a fetch or a sessions line, this is why. Related: [[reference-blc-shared-agent-skills]], [[feedback_coordinate_other_sessions_automatically]].
