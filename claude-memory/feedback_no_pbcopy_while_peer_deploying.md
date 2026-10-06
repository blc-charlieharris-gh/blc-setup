---
name: feedback-no-pbcopy-while-peer-deploying
description: Never pbcopy while another session may be feeding Charlotte paste-deploys; my console script got deployed as the broadcasts edge fn (10-06)
metadata:
  node_type: memory
  type: feedback
  originSessionId: 98c21e53-4f66-4562-8049-77b1ccd9ac89
  modified: 2026-10-06T13:00:40.893Z
---

On 2026-10-06 I put a browser-console script on Charlotte's clipboard (pbcopy) while the Hub session (blc-75) was walking her through pasting edge-function deploys. She pasted mine into the broadcasts function (v43), which broke broadcasts until redeployed.

**Why:** the clipboard is shared by every session on the machine; Charlotte pastes whatever is on it into the step she's on.
**How to apply:** when any other session is running (check ListAgents), don't pbcopy. Give a file path instead, or message the other sessions first and confirm nobody is mid-paste. The [[feedback_one_step_at_a_time_clipboard]] rule only holds with one session active. Related: [[feedback_coordinate_other_sessions_automatically]].
