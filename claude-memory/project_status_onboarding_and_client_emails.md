---
name: status-onboarding-and-client-emails
description: 2026-09-19 Status ignores onboarding clients end to end (#831/#832, edge fn v30 deployed); Reports one-click company email; National Eco email still to be added
metadata:
  type: project
---

Done and live 2026-09-19:
- #831: useStatusMonitor drops clients whose client_onboarding.status='onboarding' and re-derives overall (statusHealth.withoutClients). Go-live seeds report recipients from companies.email when the form gave none.
- #832: marketing-status-check now skips onboarding clients (per-client checks, red roll-up, support@ email) but keeps them in the lead-flow Meta sum. Deployed by Charlotte via Supabase dashboard as v30; verified deployed index.ts == origin/main. The fn now lives in the repo at supabase/functions/marketing-status-check/index.ts (was dashboard-only). Its _shared/email.ts + error-log.ts in the live bundle DIFFER from the repo's _shared copies: dashboard-deploy index.ts only, don't CLI-deploy from repo without reconciling _shared.
- Reports page: empty recipient list shows a one-click "Use their company email" button.

Open:
- National Eco has no email anywhere. Charlotte will add it on app.installrhub.com; then confirm it landed in companies.email and click the Reports button once.
- NIBE companies.email is @nibe.co.uk but members use @nibehome.co.uk, confirm before go-live.
- Mark Harvey: not live, leave (Charlotte).
- No Supabase CLI token on this Mac; edge fn deploys = dashboard paste (pbcopy the file).

Related: [[crew-roster-and-retainer-pill]], [[offer-remap-reconciliation]]
