---
name: project_handoff_rule_2026_09_22
description: "How the CREW Google session must hand off in marketing-agent: own files only, tree clean on main, prepend (never replace) handoff + CHANGELOG entries"
metadata: 
  node_type: memory
  type: project
  originSessionId: da79255b-fe3c-4017-91ec-6c33a1c2f194
  modified: 2026-09-22T12:50:00.109Z
---

Charlotte's instruction, 2026-09-22, for the CREW Google profile session ([[project_crew_google_profile_checklist]]) when it hands off:

- The audit session (Arktek/Retrofit/Renerji resends) is finished and merged, and it left nothing in the shared marketing-agent working tree.
- Commit only your own files. Leave the shared tree on `main` with nothing uncommitted. See [[feedback_commit_via_temp_index_on_main]].
- Add the handoff as a NEW SECTION AT THE TOP of both `.claude/docs/current-handoff.md` and `.claude/docs/CHANGELOG.md`. Do NOT replace the existing 2026-09-22 audit entry. See [[feedback_shared_scratch_docs_get_clobbered]].

**Why:** several sessions share one working tree and these two docs. The top entry has been overwritten before.
**How to apply:** at handoff, build the doc edits on a branch from fresh origin/main (a worktree or the temp-index recipe), prepend the new section, and check with `git diff` that the audit entry is still there before pushing.
