---
name: cherry-email-change-2026-09-02
description: "Cherry Sanglitan-Tadeo's InstallrHub login email changed to cherry@blc-promotions.com; she hit \"invalid\" on sign-in right after"
metadata: 
  node_type: memory
  type: project
  originSessionId: 7dcaef2d-315e-45ea-9443-0b77866f1529
  modified: 2026-09-03T07:45:31.625Z
---

Cherry Sanglitan-Tadeo (staff, id `2fc2cef0-9efe-47b5-9fc9-03a6fe54bff1`, admin_role `admin`, hub_role `team_member`) had her login email changed from `cmsanglitan123@gmail.com` to `cherry@blc-promotions.com` on 2026-09-02, via direct SQL against `auth.users`, `auth.identities`, and `profiles` in the shared InstallrHub Supabase project (the MCP connection is read-only, so Charlotte ran the SQL herself from the Supabase SQL Editor).

**Why:** Requested by Charlotte to move Cherry onto a BLC-branded address. One `profiles` row backs both app.installrhub.com and the hub (admin_role / hub_role columns on the same row), so the single update covers both surfaces.

**How to apply:** Right after the change Cherry reported "invalid" on internal sign-in. DB-side checks came back clean (email confirmed, password hash untouched, not banned, no pending email-change) — so the cause is on the input side, most likely a stale password (her last sign-in was ~3 months prior) or the browser autofilling her old email. Recommended she use "Forgot password" with the new address to confirm both at once. **Outcome unconfirmed** — if she reports trouble again, start from that password-reset step rather than re-suspecting the DB change, and see [[reference_installrhub_dashboard_repo_not_local]] for why the app's own source can't be grepped for the exact error string.
