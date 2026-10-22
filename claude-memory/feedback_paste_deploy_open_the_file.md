---
name: paste-deploy-open-the-file
description: "Paste-deploys: hand over the file (TextEdit or clipboard), then ALWAYS diff the live fn against the bundle and check logs after a real request; a stray key broke the portal (10-22)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6358dbe8-cace-482d-9c45-33e49d51ebdf
  modified: 2026-10-22T15:40:01.475Z
---

10-15: a bare file path got the SQL (still on her clipboard) pasted into an edge fn. 10-22: the client-portal paste file sat open in TextEdit, a stray "y" landed on its first line and autosaved; my boot check had run before, so it passed, and the live portal failed every visit ("ReferenceError: y is not defined at index.ts:1:1") until a rollback paste.

**Why:** anything between my check and her Deploy (an open TextEdit window, a clipboard a peer session overwrites, see [[feedback-no-pbcopy-while-peer-deploying]]) can change what goes live, and the boot check only proves my copy.
**How to apply:**
- Hand over: `open -e <fresh-named file>` and name its first line, or pbcopy only when no peer is deploying; close/replace the file once used.
- After she deploys, before saying done: `get_edge_function` and compare the live code byte-for-byte with my bundle, check the version went up, and query function logs for errors after a real request (ask her to open the page). A rollback copy of the previous version (bundle from the commit before) should be ready for anything client-facing.
- SQL she asks to see: inline code block, one per step.
