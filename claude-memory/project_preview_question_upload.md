---
name: project-preview-question-upload
description: Queued feature (09-22): "Allow upload" tickbox on website preview questions, reuse CREW Google photos pattern (#884), do after audit project
metadata:
  type: project
---
Queued 2026-09-22, for AFTER the audit project (likely a new session). Charlotte wants client uploads as the standard instead of Google Drive links.

**Goal:** Site Detail > InfoRequestsPanel (hub_clients.info_requests) gets an "Allow upload" tickbox per question. If ticked, WebsitePreview.jsx OpenQuestions shows an upload box under it (instead of or as well as text). Uses: photos, logos, PDFs (accreditation certs, brochures, price lists).

**Reuse CREW Google pattern** (PR #884, migration 20260922120000_crew_google_questions_photos.sql):
- PRIVATE bucket, client uploads with anon key into `<token>/...` via INSERT policy checking token through a SECURITY DEFINER helper (crew_google_token_ok + policy crew_client_photos_client_insert). Staff read/delete via has_crew_access() policies, view via createSignedUrls (sbListClientPhotos in src/context/crew/_helpers.js).
- Client's own upload list: SECURITY DEFINER RPC returning names only (crew_google_photos_public).
- Client UI: PhotoItem in src/pages/public/GoogleDelivery.jsx; "I've uploaded everything" writes a reply like "Uploaded 12 files." so the approval-blocked-until-answered gate just works.
- Staff UI: Photos in src/components/hub/google/GoogleQuestions.jsx.

**Differences:**
- Token check must hit hub_clients' own preview/signoff token, not crew_deliverables. New bucket (e.g. client-site-uploads) or generalise the helper. Do NOT reuse crew-client-photos as is (policy only accepts Google delivery tokens).
- Mime types: crew bucket is JPG/PNG/WebP/HEIC, 25 MB. Add application/pdf (maybe SVG download-only, never rendered).
- Question flag: optional `upload: true` on the info_requests entry; site-feedback reply path spreads the entry so extra keys survive (like kind: 'web3forms_key').
- Replies still via site-feedback, no new RPC.

Supabase MCP read-only: hand Charlotte SQL. Hub-only, no Serafim review needed ([[feedback-hub-only-migrations-no-serafim-review]]).
