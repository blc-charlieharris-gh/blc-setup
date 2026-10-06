---
name: feedback-build-check-every-pr
description: "Every Hub PR gets the audit checklist scoped to what it adds (settings, numbers, readers, pages affected), checked on live data, before it's called done"
metadata:
  node_type: memory
  type: feedback
  originSessionId: abcae123-e1da-48d3-abd8-b77c8029fd38
  modified: 2026-10-06T06:52:07.562Z
---

Charlotte 2026-10-06: "we won't keep running into new bugs, opening up loads of new issues??" Bugs kept landing between audits (Leave out saved but ignored, test task budget unclear), and retros were handed in partial.

**Why:** audits read code instead of doing the job as the person (Erin) does it; new builds after a page's audit were never checked; retros said "partial" and still counted.

**How to apply:** for every PR in marketing-agent, run the "B. Build check" in `.claude/docs/hub-audit/README.md`: list every new setting/number/button/auto-write, every place that reads it, and the audited pages it can affect; check each on live data; walk the job end to end as the person who does it. Retros are scoped by `git log` since the last retro and are never "partial". Any bug a person finds after audit: name the check that should have caught it and add it to the README. Related: [[feedback_audit_end_state_zero_issues]], [[feedback_audit_full_page_hidden_and_linked]], [[feedback_audit_changes_must_not_break]].

**10-06 example (Charlotte: "these are tiny things in audit that you need to consider, end to end process"):** a new access call email logged to hub_client_emails but nothing counted it: not Last chased, not the Tue/Thu chase task. For every new send or action, list every place that tracks that kind of thing (board Last chased, Snapshot, chase task, History, Actions) and make it update all of them in the same PR.
