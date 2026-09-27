---
name: feedback_ghl_send_credential_pattern
description: "Before writing any new GHL API send in marketing-agent, check _shared/ghl-config.ts's established GHL_API_KEY/GHL_INSTALLR_API_KEY pattern rather than inventing a new env var name"
metadata:
  type: feedback
  originSessionId: 73927149-6fd2-4589-a2cc-2836113068a6
  modified: 2026-09-03T16:26:42.684Z
---

Built a new SMS-send helper in `nurture-run` reading `Deno.env.get("GHL_API_TOKEN")` + `GHL_LOCATION_ID`, modeled on `scripts/push-missing-leads-to-ghl.mjs`'s LOCAL script env var naming. Deployed it, tested with a real GHL contact: 401 "Invalid JWT" on every attempt, including a plain `GET /contacts/{id}` read with the same token, while "everything else" (existing contact/tag pushes) kept working fine.

Root cause: `GHL_API_TOKEN` was never a real credential anywhere in this codebase's actual edge-function auth pattern — it doesn't exist as a live secret with that exact name for functions. The real, established pattern (found by reading the already-working `ghl-sms` function's shared import chain, `_shared/ghl-config.ts`) is: two GHL sub-accounts, `'leads'` (homeowner side, `GHL_API_KEY` + `GHL_LOCATION_ID`) and `'installr'` (installer side, `GHL_INSTALLR_API_KEY` + `GHL_INSTALLR_LOCATION_ID`), both hitting `https://services.leadconnectorhq.com` with `Version: 2021-07-28`. `scripts/push-missing-leads-to-ghl.mjs`'s `.env`-based `GHL_API_TOKEN` naming is a **local script convention only** — it does not correspond to any edge-function secret, and matching its name for new edge-fn code produces a token that plausibly looks right but is simply undefined/wrong at runtime.

**Why:** the codebase has two independent, differently-named credential conventions for the "same" GHL account depending on context (local Node script vs. deployed edge function), and nothing forces a new author to discover the right one before shipping — the 401 only surfaces at actual send time, deployed, against a real contact.

**How to apply:** before writing ANY new code that calls GHL's API from a Supabase edge function in this repo, grep for `_shared/ghl-config.ts` and `getGhlConfig` first, and reuse `GhlTarget` (`'leads'` vs `'installr'`, matched to whether the contact is a homeowner or an installer/prospect) rather than inventing a new env var name from a local script or from generic API docs. If a 401/"Invalid JWT" shows up on a brand-new GHL integration, first suspect the credential name itself, not scopes — test the SAME token against a trivial read endpoint (`GET /contacts/{id}`) to confirm whether the token is dead entirely vs. just missing a specific permission. See [[reference_nurture_engine]] for the concrete fix.
