---
name: feedback_ads_manager_unpublished_drafts
description: "Ads Manager \"unpublished\" on objects switched on by API = held draft edits, discard is safe; API can't read drafts"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c21ce03-b699-4323-91f1-0ce4fff3d770
  modified: 2026-10-07T14:14:45.360Z
---

2026-10-07, Elect go-live: ad set + 3 ads switched ACTIVE by API (effective ACTIVE), but Ads Manager still showed them "unpublished". That label is Ads Manager's own draft edits held on top of the live objects. Charlotte feared discarding would delete the ads; it didn't, the live objects stayed ACTIVE.

**Why:** publishing old drafts can undo API changes (e.g. a draft holding an earlier switch-off), and discarding looked to her like it would remove the ads.
**How to apply:** check the live state via API first, snapshot the full setup (campaign, ad set, ads + creatives, form) to the clone workdir, then advise "Discard drafts" and re-check status after. `act_X/addrafts` returns 400, so the drafts' contents can't be read from here. After a new client's campaign goes live, run the one-client meta-sync before hub_note.py ([[reference_manual_meta_sync_single_client]]).
