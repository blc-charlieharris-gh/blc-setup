---
name: api-imports-need-js-extension
description: "marketing-agent src/lib files imported by api/*.js must use .js on relative imports, or Vercel functions crash while vite/vitest pass"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 074717eb-e574-4f49-9c99-c126f7aaa2b7
  modified: 2026-09-24T14:12:32.117Z
---

In marketing-agent, api/*.js runs in plain Node on Vercel. Any src/lib module it imports (onboardingEmails.js, auditVerdict.js) must write relative imports WITH `.js` (`from './goLiveRecipients.js'`). Vite and vitest resolve extensionless imports, so the suite stays green and the function dies with FUNCTION_INVOCATION_FAILED in production.

**Why:** #862 (2026-09-21) added `./goLiveRecipients` to onboardingEmails.js; the automatic onboarding email cron crashed silently for 3 days (nothing sent 18-24 Sep, Hea wise missed its welcome). Found 2026-09-24 via Emails > Onboarding "Status failed (500)". Fix branch fix/onboarding-sender-import adds src/lib/serverImports.test.js, which loads each api-imported module in plain Node.

**How to apply:** when editing a src/lib file that api/ imports, keep `.js` on relative imports; to probe a live api route, `curl` it: a 500 "FUNCTION_INVOCATION_FAILED" before auth means module load failed. See [[prebuilt-deploy-overrides-main]].
