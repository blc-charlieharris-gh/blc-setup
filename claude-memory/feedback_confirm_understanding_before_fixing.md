---
name: feedback-confirm-understanding-before-fixing
description: "Before fixing anything Charlotte raises, play back what I think she means + the planned fix in plain words and get her OK; never fix on assumed understanding"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-08T20:42:48.762Z
---

Charlotte 2026-10-08: "in future, don't just fix or break on assumed understanding, check with me you understand first."

Trigger that day: she raised "tagging single ads brings up the launcher not the tagger". I treated it as fixed (code now opened a small tagger), but what she wanted was a tagger that opens like the creative test, showing the campaign and the launched images with a sync-from-Meta button. Same pattern with other audit steps: I built my reading of the issue without checking.

**Why:** a wrong reading ships a "fix" she then has to re-raise. It costs her a round trip and adds new bugs.
**How to apply:** for every issue she raises, before building, send a short playback: "You mean X happens; you want Y. I'd fix it by Z. Right?" Use AskUserQuestion when there are real options. Build only after she confirms. Investigation (read-only) can start straight away; changes wait. Applies to helper agents too: their prompts must carry her confirmed wording. Related: [[feedback_diagnose_stated_symptom_not_substitute]], [[feedback_build_check_every_pr]].
