---
name: Session management is Claude's job, not the user's
description: Session start/end must be fully autonomous — no questions to the user, Claude reads all context and presents a briefing
type: feedback
originSessionId: d7e50000-770d-4b19-861d-ba2a8c0eff36
modified: 2026-09-03T07:45:10.910Z
---
Session start and session end are Claude's responsibility, not the user's. Never ask "what are you working on today?" or "what did you accomplish?"

**Why:** The user has had to answer these questions repeatedly and explicitly told me this is wrong. I should know where we are from memory, changelogs, and last-session files.

**How to apply:**
- On session-start: read all project memory files, present a structured briefing across all three projects (Greentide, InstallrHub, ClientSiteGenerator), then ask only "Which project are we in today?"
- On session-end: synthesize what was accomplished from the conversation, identify the active project, and update the relevant project memory files directly. No questions.
- When the user says "put me in [project]", load that project's context and proceed — no further questions.

**Correction (2026-09-03):** The `session-end.sh` / `session-start.sh` scripts this memory originally referenced (run from `/Users/charlotteharris/Documents/BLC/`) no longer exist — only a stale copy of the old slash commands survives in `.claude-backup/commands/session-end.md` and `session-start.md`, and the live `.claude/commands/` dir is empty. Don't try to run a script on session-end; just write the summary straight into memory files as described above.
