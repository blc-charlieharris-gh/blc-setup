---
name: feedback_paste_ready_code_must_be_own_text
description: "When handing the user copy-paste-ready code/SQL to run themselves (dashboard editor, SQL Editor), it must come from Claude's own directly-authored text response, not a Read/Bash tool result — those add line-number prefixes or get truncated/persisted to a file, breaking the paste"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: cd08782b-d7b0-464e-a222-58f01441d3f5
  modified: 2026-09-08T11:52:02.077Z
---

Twice in one session (2026-09-07/08), handed a user a large paste-ready file (a Postgres function, an edge function) via a tool result instead of writing it directly as my own text output, and it didn't work for them.

- `Read` prefixes every line with `N\t` (cat -n style). Fine for me to read, but if the user copies the tool-result block straight into a dashboard editor, those line numbers paste in too and break the code.
- `Bash cat file` on a large file (>~30KB) gets truncated to a preview and the real content persisted to a local file path the user can't see or open, they just see "output too large, saved to <path>".

**The fix that actually worked:** read the file's clean content into my own context first (Read is fine for that), then reproduce it as a plain fenced code block in my own directly-authored chat message, not as a tool call result. Only text I write myself, outside of tool use, is guaranteed to render clean and complete for the user to copy.

**How to apply:** any time the deliverable is "here's the code, paste this yourself" (dashboard SQL Editor, edge function editor, anywhere I don't have write access), always paste it as my own text response, never rely on a Read/Bash tool result being copy-pasteable, regardless of size.
