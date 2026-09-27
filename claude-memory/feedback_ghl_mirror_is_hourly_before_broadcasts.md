---
name: feedback-ghl-mirror-is-hourly-before-broadcasts
description: "Broadcast audiences read the Hub's hourly GHL mirror, not GHL live; run Sync now if contacts were pruned within the hour before a send"
metadata:
  node_type: feedback
  type: feedback
---

Broadcast audiences are built **at send time, not at schedule time** (good), but they read
`mailing_contacts`, which is the Hub's **mirror** of the GHL InstallrHub sub-account, refreshed
by cron at **17 minutes past each hour**. `mailing_audience()` starts with
`WHERE removed_at IS NULL`, so deleted contacts are excluded, but only once a sync has noticed
them. The mirror can be up to 60 minutes stale.

So the exposure window is: anyone deleted in GHL **between the last :17 sync and the send time**
is still on the list and will be emailed.

Demonstrated 2026-09-23: 21 past clients were deleted from GHL between 09:17 and 10:01 BST. The
09:17 cron sync saw 526 contacts and `removed: 0`. A manual sync at 10:01 caught all 21 and the
count dropped to 507. Webinar Email 1 was due at 11:16, and the 10:17 cron would have caught them
anyway, but only by 59 minutes.

**How to apply:** if GHL has just been pruned and a broadcast fires within the hour, run
**Hub > Emails > Mailing list > "Sync now"** first. Manual syncs have a 3-minute cooldown, crons
have 10, so a manual one always runs. Do not assume the count in the Hub is live.
Two further safety nets exist: the seed address gets every broadcast 30 minutes before everyone
else, and mid-flight broadcasts drop removed contacts at each exit check.
Related: [[reference_installer_lead_flow_and_mailing_list]], [[project_broadcasts_mailing_list]]
