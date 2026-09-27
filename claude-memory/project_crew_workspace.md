---
name: project_crew_workspace
description: CREW — AI organic-marketing team sold to installers as a subscription; staff/ops console built into the marketing-agent Hub
metadata: 
  node_type: memory
  type: project
  originSessionId: d7f4619a-b326-408f-a1d0-4937bf075174
---

CREW is a side project: an AI "organic marketing team" BLC sells to installers on subscription. Three services a client can buy: **Website** (design + hosting), **SEO** (audit + monthly management), **Socials** (fully managed). Built as a staff/ops console, NOT the customer-facing pitch (that older customer product is the parked `crew/` dir + `crew-pitch*.html` at BLC root, named workers Mia/Riley/Bella; different thing).

**Home:** the `marketing-agent` repo (React 19/Vite/Tailwind/Supabase Hub that serves internal.installrhub.com — see [[reference_internal_installrhub_is_marketing_agent]]). New `/crew` route + CREW nav section. NOT the archived `internal-installrhub` repo (a vanilla-HTML Phase-1 was mistakenly built there first and parked, unpushed).

**Model:** `crew_clients` Supabase table = master client roster (packages jsonb {website,seo,socials}, brand_type own_b2c/own_b2b/client, fb_page_id, ig, research jsonb, scores jsonb, status). The **Website** service reuses the existing `/sites` + `hub_clients` builder, linked by **shared slug id** (no FK). SEO + Socials are new modules. Seeded with Greentide (B2C) + InstallrHub (B2B) as own brands.

**Phase 1 (shipped to branch `feat/crew`, pushed, awaiting Vercel preview then Serafim):** CREW tab shell — client dropdown w/ package badges, brand/status chips, Overview/Website/SEO/Socials tabs, onboarding modal. `CrewContext` + `crew/` slice mirror `ClientsContext`. **Demo-mode fallback**: if `crew_clients` table absent (pre-Serafim), roster seeds in-memory + onboarding is local, so preview is fully clickable with no backend (amber banner says so). Migration `20260705000000_crew_clients.sql` is Tier-2, batched to Serafim at the end (user wants to preview first).

**Roadmap (user wants "real end-to-end, one client"):** P2 = one-click client research (Firecrawl+Anthropic) + tri-score SiteScore/SocialScore/SearchScore → blended InstallrScore + shareable report mirroring SiteScore. P3 = month content plan (5 FB + 3 IG/wk, mixed formats, Haiku copy, OpenAI/gpt-image images + Google Drive client content), email+Actions "plan ready" → approve/edit/regenerate loop. P4 = calendar w/ best-practice times, auto-post FB/IG via Graph. P5 = daily engagement cron + re-audit + fresh 30-day plan. Client front-end progress view = placeholder (lands in CRM).

**Pilot:** a test FB page **Renewables4U** (user creating it under BLC Promotions, we own it → real posting, no App Review). **Images:** OpenAI/ChatGPT gpt-image (needs OPENAI_API_KEY in Vercel env); Higgsfield as backup. **Meta:** full access already, token in `meta-access/.env` (`META_ACCESS_TOKEN`, Marketing API v21.0); page posting needs the page granted to that system user.

**Testable-when:** UI/flow = preview now (demo mode). Persistent roster = needs Serafim table. SocialScore/real posting = needs Renewables4U page + Meta page-token. See [[feedback_serafim_signoff_and_handoffs]], [[reference_git_auth]].
