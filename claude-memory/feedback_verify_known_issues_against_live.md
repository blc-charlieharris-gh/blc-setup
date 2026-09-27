---
name: feedback-verify-known-issues-against-live
description: Before repeating a known-issues or old-note claim to Charlotte, check it against live data/code; she has fixed many of them and gets frustrated re-hearing stale ones
metadata:
  type: feedback
---

On 2026-09-25 I told Charlotte "the homepage, contact and resources n8n workflows don't pass the referrer", straight from a 2026-08-19 known-issues line. She had fixed most of it ("I've been over this so many times with you"). Live data showed the webinar form passes everything; only the homepage form dropped the referrer (one example).

**Why:** known-issues.md and old handoffs go stale fast in this repo; Charlotte explicitly said "double check, I don't want you looking at old notes".
**How to apply:** treat known-issues / handoff claims as leads to check, not facts. Query live data or read the deployed function before stating a gap, and say how you verified it. See [[feedback_stale_urgency_label_verify_against_live]].
