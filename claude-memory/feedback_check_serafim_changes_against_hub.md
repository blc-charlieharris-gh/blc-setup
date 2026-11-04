---
name: feedback-check-serafim-changes-against-hub
description: "Serafim's changes (his app or his PRs in our repo) can break the Hub; check each one against Hub tables/triggers before and after it runs"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 34b389b0-eccd-4528-8b2b-5d8ee26385df
  modified: 2026-11-04T14:18:36.166Z
---

Charlotte, 4 Nov 2026: "we need to keep tabs on what serafim is fixing his side as it's messing with the hub."

Serafim's #3163 (Hub side of the sales CRM link, his commit in marketing-agent) added a trigger on email_suppressions + sms_suppressions that named new.email and new.phone together; every block-list insert failed 11:09-14:13 (unsubscribes, STOPs, bounces, Do not contact all lost). Fixed by 20261104141300; found only because Charlotte noticed John Murphy's unsubscribe didn't show.

**Why:** his work touches tables the Hub writes to (block lists, mailing list, outbox, triggers) and nobody on the Hub side checks it before or after it runs.
**How to apply:** Charlotte also said "anything that impacts us at all we need know, wherever it touches anywhere in the hub": report every touch, helpful or harmful, and CRM switch changes. at prime and handoff, list Serafim's commits since the last check (`git log origin/main --author=Serafim`) and any migration that adds a trigger or changes a function on a Hub table; for each, test-insert/read the Hub path it touches and scan postgres_logs for new errors since it ran. Flag anything to Charlotte with a fix. Related: [[feedback_serafim_signoff_and_handoffs]], [[feedback_serafim_claude_note_is_sql]], [[feedback_whole_impact_before_any_change]].
