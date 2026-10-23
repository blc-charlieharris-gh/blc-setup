---
name: feedback-test-after-switch-off
description: "When retiring a system (n8n, GHL), test the chain AFTER switching it off, and check how a result arrived, not just that it arrived"
metadata:
  node_type: memory
  type: feedback
  originSessionId: e2e131f3-b9b3-4dc8-b2a1-45a7fd7fc5ed
  modified: 2026-10-22T21:43:37.120Z
---

On 10-20 the Green Tide lead test passed while n8n was still on. n8n was paused afterwards and nobody re-tested. The session also concluded "Green Tide's GHL copies new contacts" from the test lead arriving, without opening the GHL workflow, which was a webhook to n8n. Real new Green Tide leads then failed silently on 10-22 (see [[project_greentide_new_leads_not_reaching_telesales_1022]]).

**Why:** a test run while the old system is still live proves nothing about life without it, and "it arrived" hides which path delivered it.

**How to apply:**
- When switching anything off, re-run the end-to-end test after the switch-off.
- Check which writer produced the record (raw.via, source), not just that one exists.
- Before writing "X does Y" into code or memory, open X and look at its actual action.
