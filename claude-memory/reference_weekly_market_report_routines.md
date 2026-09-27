---
name: weekly-market-report-routines-and-their-delivery-pipe
description: "Two Claude cloud routines email Charlotte weekly market research; their sandbox can only reach github.com, so they write JSON into blc-charlieharris-gh/weekly-reports and a GitHub Action sends it via Resend"
metadata: 
  node_type: memory
  type: reference
  originSessionId: b19fab95-e88f-49fe-ba7d-476d91139709
  modified: 2026-08-03T13:13:59.099Z
---

Two routines at <https://claude.ai/code/routines>, both Monday morning, no repo attached, WebSearch + WebFetch + Bash:

| Routine | Cron (UTC) | Writes |
|---|---|---|
| Weekly UK Heat Pump and Solar Trends (`trig_0177eCnNm7MHHVmnbvDrp97E`) | `0 7 * * 1` | `outbox/<date>-search-trends.json` |
| Weekly UK Installer (B2B) Market Report (`trig_01DoLLiu8EP1sy9Ao6vtvaT2`) | `0 8 * * 1` | `outbox/<date>-installer-market.json` |

**THE KEY CONSTRAINT, measured 2026-08-03:** the CCR sandbox's proxy bypasses ONLY `anthropic.com`, npmjs, jsr, pypi, crates and proxy.golang.org. `api.resend.com`, `*.supabase.co`, `marketing-agent.vercel.app` and `installrhub.com` all return **403 on CONNECT**. So a routine CANNOT send email or call any of our infrastructure. Don't re-attempt it.

**The pipe:** routine PUTs the report JSON to `blc-charlieharris-gh/weekly-reports` via the GitHub contents API (`api.github.com` is reachable) → push fires `.github/workflows/email-report.yml` → `scripts/send-reports.mjs` sends via Resend from a runner with real internet. Only files ADDED by the head commit are sent, so a re-run can't re-send.

**Secrets:** `RESEND_API_KEY` is a repo secret on weekly-reports (NOT in the routine prompts). Each routine prompt holds a fine-grained GitHub PAT (`claude-routine-reports`, Contents read+write on that repo only). **If reports stop arriving, check that token has not expired before anything else.**

**Gmail connector can only create DRAFTS, it cannot send.** The original routine said "send via the Gmail tool", so for months it silently produced drafts and reported success. Every layer now refuses to claim success without proof: routine needs HTTP 201, sender needs a Resend id, workflow exits non-zero otherwise. See [[feedback_silent_fallbacks_hide_dead_features]].

Report content rules live in the prompts: never invent a statistic, label unverified figures NEEDS VERIFICATION, takeaways written as decisions not observations, and always separate retrofit from new build (see [[project_installrhub_retrofit_market]]).
