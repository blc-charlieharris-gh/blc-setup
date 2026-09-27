---
name: feedback_check_history_before_building
description: Before building a "new" feature in marketing-agent, search git log for one that was built and later removed; Charlotte remembers features that were reverted
metadata:
  type: feedback
---

On 2026-09-22 Charlotte asked for a way to chase Meta access by email. I built a new CREW card (#905) for it. It turned out that an "Email access request" button on the Manage Clients client card had been built on 09-21 (#850) and removed 20 minutes later (#852, "one-off for Harvard/Core"). She remembered it and couldn't find it. The fix was to revert #852 and delete my duplicate.

**Why:** features in this repo get added and then pulled within hours. When Charlotte says "we had X", or asks for something that sounds familiar, the code has probably existed before, possibly in a different place than I would pick.
**How to apply:** before building, run `git log origin/main --oneline -i --grep="<keyword>"` and `git log -G "<keyword>"` over the last few weeks. If an earlier version was removed, offer to restore it (via `git revert` of the removal) rather than build a new one somewhere else.
