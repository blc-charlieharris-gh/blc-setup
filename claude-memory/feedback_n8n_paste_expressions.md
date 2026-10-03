---
name: feedback-n8n-paste-expressions
description: "n8n pastes for Charlotte - reference the webhook node by its real name, JSON.stringify multi-line values, GHL note node takes plain text not {\"body\":...}"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 5a111bcf-16ac-42d5-be7d-23ad886130dc
  modified: 2026-10-03T14:16:09.698Z
---

When giving Charlotte n8n expressions/bodies:
- FIRST for any GHL note: give the plain-text expression only, never JSON.stringify({body: ...}). Repeated on 3 Oct pm (client MOT notes posted as raw JSON) despite this rule existing.
- After a GHL HTTP step, `$json` is GHL's reply, not the form. Read form fields with `$('<webhook node name>').item.json.body[...]` and ask for the exact node name first (InstallrHub MOT webhook node = "MOT-Installer lead magnet", client MOT = "CLIENT MOT"; "Referenced node doesn't exist" = wrong name). Never point it at the GHL node.
- Multi-line or free-text values (MOT answers has \n) break a raw JSON body inside "{{ }}"; use `{{ JSON.stringify(...) }}` without surrounding quotes.
- Her GHL "Create note" node has its own note-text field: give only the expression, not a {"body": ...} wrapper (it got posted literally).
- She prefers the fewest nodes: one note node with a ternary over an IF split; one summary custom field over many.

**Why:** 3 Oct 2026 MOT wiring took four rounds over exactly these. **How to apply:** ask node names and node type before writing the paste. Related: [[reference-installrhub-n8n-payload-fields]].
