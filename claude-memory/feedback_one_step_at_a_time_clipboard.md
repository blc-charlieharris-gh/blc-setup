---
name: feedback-one-step-at-a-time-clipboard
description: Charlotte runs SQL/deploys one step at a time, each copied to her clipboard with pbcopy; check each live before the next
metadata:
  type: feedback
---

Charlotte 2026-10-05: "will need to go one at a time" and "no copy to clipboard". For any run/deploy sequence, give ONE step per message, put that file on her clipboard (`pbcopy < file`), say where to paste (Supabase SQL Editor / Edge Functions > fn > Code) and what success looks like, then verify it live (SQL check, function version + boot logs) before handing the next. Number SQL files in run order in `~/Code/BLC/_deploy/<date>/`.

**Why:** long multi-step lists get lost in chat; she re-asks for files.
**How to apply:** when she says "again", just re-pbcopy the same file. Before a paste-deploy of an edge fn she hasn't heard of, say whose it is and diff live vs our base first. Related: [[feedback_charlotte_plain_explanations]], [[feedback-paste-ready-code-must-be-own-text]].

**Clipboard is shared by every session (2026-11-02):** another session's pbcopy overwrote meta-sync's paste file before she pasted, so Supabase refused "index.ts:1:12 -- Webinar questions...". Say the file's first line (e.g. `// @ts-nocheck (single-file copy...`) and size so she can check before Deploy, and re-pbcopy right before she pastes if another session is live.
