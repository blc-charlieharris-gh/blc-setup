---
name: project-security-lockdown-0930
description: Hub security lockdown live 30 Sep (staff-only RLS, profiles guard, 5 fns redeployed, agent-* deleted); app-side list sent to Serafim
metadata:
  type: project
---

30 Sep 2026: Hub side CLOSED and verified live: hub_is_staff() on 52 Hub + 4 shared tables, profiles guard blocks self-change of is_admin/admin_role/company_id/is_installer/can_settle_payments, temp_offer_remap dropped, anon off meta_lead_events, crew-login/crew-audit-request/blog-cron/marketing-sync-meta/meta-quality-sync redeployed (secret or staff), agent-apply/execute/tweak + marketing-sweep deleted. Cron jobs send x-hub-cron-secret (vault hub_cron_secret).

**Open:** check the 01 Oct 04:00 marketing-sync-meta-daily run succeeded. Crew portal "request audit" is staff-only until the Crew audit. App-side holes (send-lead-sms/email, ghl-sms, claim-slot, setup-admin, setup-password, leads RLS...) are Serafim's, note sent 30 Sep; report in repo .claude/docs/hub-audit/security-2026-09-30.md. Never write a hub_is_staff-guarded RPC with CREATE OR REPLACE without keeping the guard.
