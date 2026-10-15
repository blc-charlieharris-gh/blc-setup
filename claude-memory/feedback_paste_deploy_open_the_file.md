---
name: paste-deploy-open-the-file
description: For a paste-deploy with other sessions running, open the file for her (open -e) and name its first line; a bare path got the SQL pasted into an edge fn (10-15)
metadata:
  type: feedback
---

On 2026-10-15 I gave Charlotte the SQL as a code block, then a file path for the hub-action-alerts paste copy. She pasted the SQL (still on her clipboard) into the edge function editor, and the deploy failed with "Expected ';'... Actions clean-up". No harm, as nothing deployed, but it cost a round.

**Why:** with peers running, pbcopy is off ([[feedback-no-pbcopy-while-peer-deploying]]), and a path alone leaves her copying from wherever her clipboard last was.
**How to apply:** for a paste deploy, run `open -e <file>` so it opens in TextEdit (VS Code's `code` CLI isn't on PATH here), say "Cmd+A, Cmd+C in TextEdit", and give the first line to check before Deploy (for a bundled fn: `import "jsr:@supabase/functions-js...`). For SQL she asks to see, paste it inline in a code block, one block per step.
