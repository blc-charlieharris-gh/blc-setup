---
name: reference-client-mot-link
description: /client-mot is the Installer MOT for existing clients, personal link ?cid={{contact_id}}, gated by Hub client_mot_lookup, n8n ...motclient adds notes only
metadata:
  type: reference
---

Client MOT (live 3 Oct 2026, site PRs #108/#109): `installrhub.com/client-mot?cid={{contact_id}}` (GHL Installr contact id; Hub broadcasts support the merge field). `api/_client.js` checks Hub RPC `client_mot_lookup` (current or past client) on load and every write; non-clients get a button to /installer-mot. Form key `installrhub-client-mot`, n8n webhook ending `0321motclient` = webhook > Add note only (no field, no tags, so never a lead). Bookings: calendar `o3IPDucRtZtsioEQDiNB`, onto the existing contact, no upsert. Answers land in `site_form_submissions.answers` for the Hub client card (completed only). Test client: Gas Worx cid H0XNBzVwJz5DlLTvxImE (company named "Stuart Hall" in companies). Related: [[feedback-n8n-paste-expressions]].
