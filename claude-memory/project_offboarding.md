---
name: BLC Offboarding Plan
description: Charlotte may leave BLC/Green Tide in the future. Flag any personal account entanglements and build systems to be company-owned, not person-owned.
type: project
originSessionId: 9bc88962-cd7c-4ec0-9ad4-722987e7dd57
---
Charlotte may leave BLC/Green Tide at some point. Any systems, tools, or credentials built for BLC should be owned by BLC, not by Charlotte personally.

**Why:** If personal accounts are used for company systems, those systems break or become inaccessible when Charlotte leaves.

**How to apply:** When setting up any API keys, tokens, accounts, or integrations for BLC projects, flag if they are tied to a personal account and suggest using a BLC/company account instead.

## Accounts to audit before leaving

- **Anthropic API:** Keys are workspace-owned and stay active after the creator is removed from the workspace, so personal keys are lower risk here. Still worth moving to a BLC workspace eventually.
- **Vercel:** Deployments and tokens should be under the BLC/Green Tide Vercel team, not a personal account
- **GitHub:** Repos should be under the `blc-charlieharris-gh` org or transferred to a BLC org
- **Google:** Any Google accounts used for ads, analytics, Search Console should be BLC-owned
- **Domain registrars:** greentide.co.uk and any client domains should be registered to BLC
- **Stripe / payment accounts:** Should be company accounts
- **Any other SaaS tools** used to run the business

## General rule

Before building anything new for BLC, ask: "If Charlotte left tomorrow, could BLC still access and run this?" If not, flag it.
