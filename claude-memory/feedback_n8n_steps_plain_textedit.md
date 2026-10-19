---
name: n8n-steps-plain-textedit
description: n8n/GHL instructions as numbered click-steps, full body in a TextEdit file, no "may"; say what to replace and why in one line
metadata:
  type: feedback
---
When Charlotte has to change an n8n flow or GHL: give numbered click-steps (which flow, which step, delete whole body, paste, save, how to test), put the full code in a `_deploy/*.txt` file and `open -e` it, and say in one plain line what changes and why. Never hedge ("may not be passing it on") without checking, and never offer a half fix that she then has to undo.

**Why:** 2026-10-19 she said "I have no idea what you're saying": a table of ⚠️ findings, a half-fix DTO body, and "may" about n8n confused her; she asked for code in TextEdit.
**How to apply:** one item = what's wrong, what to do, the file. Links as /compare/main...branch?expand=1 (a typo'd pull/new link failed). Related: [[feedback-n8n-paste-expressions]], [[feedback_paste_deploy_open_the_file]].
