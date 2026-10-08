---
name: project_client_drive_build
description: "Client media via Google Drive (10-08): parent folder id, access rules, the plan (page upload -> Drive, staff pick into client footage), what Charlotte still has to set up"
metadata:
  node_type: memory
  type: project
  originSessionId: a7056869-0697-4dca-a1f1-bf3641f3c832
  modified: 2026-10-08T09:34:40.464Z
---

Charlotte 2026-10-08: client photos/videos live in OUR Google Drive, never stored in the Hub unless staff pick them.

- Parent folder (admins / super admins only): `1y5f6W6DbLbLpQnHxx4bgvDPIDFChF1F9`
  (https://drive.google.com/drive/folders/1y5f6W6DbLbLpQnHxx4bgvDPIDFChF1F9).
- One folder per client inside it, made by the Hub, shared with the team (not the parent). Clients do NOT get Drive
  access by default: they upload from their InstallrHub page (no Google account). Drive email-shares confuse clients
  (wrong Google account -> "Request access" emails to Charlotte). Optional per-client "anyone with the link can view".
- Staff see the client's Drive files on the card (New badges, preview, download) and choose "Add to client footage"
  (creative_broll with client_id; must take images AND videos, Charlotte yes). Uploads from the page notify at once;
  files dropped straight in Drive found by an hourly check.
- Google/social page photo uploads (crew-client-photos bucket) move to the same Drive upload. blc-43's clientPhotos
  (crewCrudSlice.js) must switch source at the same time or "their photos first" silently stops.
- Auth: OAuth web client in a Google Cloud project, Internal audience (Workspace), Drive API; redirect
  `https://ozmyjrzleejbqxqphbut.supabase.co/functions/v1/google-drive-auth`; secrets GOOGLE_DRIVE_CLIENT_ID /
  GOOGLE_DRIVE_CLIENT_SECRET in Supabase Edge Function secrets (Vercel holds no service key by design).
- Decided 10-08: must be in the BLC Shared Drive (parent folder limited access, admins). Crew pictures (social posts,
  "Use their photo") come ONLY from photos staff added to client footage, never straight from Drive. Who opens client
  folders = active Hub users with crew OR marketing OR clients permission, plus ultra_admins (Charlotte: no separate
  tick). On 10-08 that's Charlie, Brad, Serafim, Erin, Kornelius, Cherry. Permission changes in Users re-share/unshare.
  NOT "all active users" (active team_members include clients' staff, demo, Serafim's test login).
- Folder is NOT in a Shared Drive: breadcrumb "Shared with me > Creatives Hub > Creatives Library" (a colleague's
  Drive, shared to her). Kept as is (Charlotte lost on moving it). Connected Google account = charlieharris@installrhub.com
  (Workspace installrhub.com; Cloud audience Internal). Hub logins are @blc-promotions.com, so team shares need each
  person's Google (installrhub.com) address: asked 10-08 whether all six have one.
- Open with Charlotte: her doing the Cloud steps as charlieharris@installrhub.com; team Google addresses.

Related: [[project_client_area_plan]], [[feedback_nothing_device_linked]].
