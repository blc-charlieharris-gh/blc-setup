---
name: feedback-one-report-at-end
description: "During long multi-part runs (audits, many builds) Charlotte won't catch interim messages; give ONE complete, self-contained report at the end"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-09T14:01:08.040Z
---

Charlotte 2026-10-09, starting the multi-page retro audit: "all this building, I will not catch your messages, so make sure you give me it all at the end."

**Why:** her view loses earlier messages ([[feedback_messages_self_contained_chat_resets]]), and interim updates get buried.
**How to apply:** while helpers run, keep progress notes to one line (or none). When everything is done, send ONE consolidated report: every area, every finding (simple format, see [[feedback_audit_findings_simple_with_options]]), every action needed from her in order, and every PR/SQL/deploy step. For long reports, publish a private artifact page and give her the link plus a short summary. Nothing in it should rely on an earlier message.
