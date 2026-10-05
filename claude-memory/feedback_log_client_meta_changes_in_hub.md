---
name: feedback-log-client-meta-changes-in-hub
description: "Every change on a client's Meta account gets a 'change' note on that campaign's Hub History (campaign_checkins); give Charlotte the SQL, then verify"
metadata:
  node_type: memory
  type: feedback
  originSessionId: b6483af9-04b0-4d00-bd4c-5f9c7dde0606
  modified: 2026-10-05T14:37:12.368Z
---

Charlotte (2026-10-05): "whenever I ask you to do something on a client account, add the client note to the campaign in the Hub". This covers targeting, creatives, copy, budgets and on/off changes.

How: one `campaign_checkins` row per campaign, kind `change` (the sky "change" badge on the client card History and Actions > History), with the note in plain words plus the date. Use `created_by_name` 'Claude (for Charlie)', since the trigger only fills the author when there's a login. Look the campaign up by `ads_campaigns.external_id` (the Meta id). The template is in meta-access/CLAUDE.md.

**Why:** the team reads the client's history in the Hub. Changes made through the API were invisible there.
**How to apply:** Claude can't write to Supabase ([[reference_blc_supabase_cli_wrapper]]), and neither can the Hub session. So at the end of every client-account task, write the paste-ready SQL in the reply (as your own text, [[feedback_paste_ready_code_must_be_own_text]]), then verify with a select once she says it's run. Use kind `change`, not `note`, because notes feed the daily-check/action flow ([[project-client-catchup-helper]]).

**Update 2026-10-05:** Charlotte approved a notes-only door. `python3 meta-access/hub_note.py <campaign id> "<note>" --field ...` calls Hub edge fn `hub-note` (live, PRs 1466 + 1471, verify_jwt off). It's authorised by the Meta system-user token (checked against Meta /me, must be Agent 122093126715339384), so it works on any machine that can make Meta changes; there's no extra key (HUB_NOTE_KEY removed, Charlotte doesn't want anything device-linked). It can only insert kind='change' rows. Use it directly, and fall back to SQL only if it fails. The first 5 notes (10-05) went in as SQL, so don't re-post them.
