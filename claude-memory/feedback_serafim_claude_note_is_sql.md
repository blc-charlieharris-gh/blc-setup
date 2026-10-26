---
name: feedback-serafim-claude-note-is-sql
description: "Anything for Serafim's Claude goes as a cross_agent_notes INSERT SQL she runs, plus a short plain message for Serafim himself"
metadata:
  node_type: memory
  type: feedback
  originSessionId: fc073161-15a1-457a-b65b-e017c6693ad1
  modified: 2026-10-26T08:52:56.532Z
---

Charlotte, 26 Oct 2026: "HOW DO WE GIVE HIS CLAUDE THE MESSAGE?! you usually give me sql?" I had handed her a .md file "for his Claude" with no way to deliver it.

**Why:** his Claude only reads cross_agent_notes; a file on our Mac never reaches it.
**How to apply:** whenever Serafim's app needs a change, give BOTH up front: (1) a 3-4 line plain message for Serafim, (2) a paste-ready `insert into cross_agent_notes (author, audience, topic, ref_id, body)` with author 'marketing', audience 'installrhub', topic starting 'ASK (your app code): ...', body in $note$ quoting, opened in TextEdit from ~/code/BLC/_deploy. Say plainly it only adds a note, no data change. Verify the row by ref_id after she runs it. Related: [[feedback_serafim_signoff_and_handoffs]], [[feedback_n8n_steps_plain_textedit]].
