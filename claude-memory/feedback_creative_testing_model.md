---
name: feedback_creative_testing_model
description: "marketing-agent Creative Testing domain model - creatives are shared, performance + tagging are per-campaign"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 0c5c6db7-669d-4b60-b1b5-15e1ba635b38
---

The Creative Testing area in marketing-agent (`CreativeTesting.jsx`, `useCreativeTestData.js`, `creative_tests`/`creative_test_campaigns`/`creative_test_ads`) has three non-obvious rules that caused repeated wrong diagnoses:

1. **A creative (visual) is client-agnostic.** The backlog/library is one shared pool across all clients. `creative_tests.client_id` is a weak/defaulted field, NOT ownership. Only **ad performance** is client-scoped, by the **campaign's** owning client. So scope the currently-testing / by-campaign boards by the campaign's client (`perCampaign[].campaign_client_id`), never by `test.client_id`, or a shared visual tested on another client's campaign leaks into the wrong scope.

2. **Tagging is per campaign, not per test.** The same visual runs as a different live ad in each campaign; each active leg needs its own tag. `creative_test_ads` has a `campaign_id`, and `perCampaign[].tagged` is the per-leg truth. The global `test.tagged` (any tag exists) is misleading, so surface per-leg tag status and make `needsAttention` flag any active untagged leg.

3. **`test.campaigns` includes ENDED (inactive) legs.** `useCreativeTests` builds it with no active filter. So exclude by `tc.active` when deciding what to hide, e.g. `StartTestModal` must hide only ACTIVE legs, otherwise a creative can never be re-tested on a campaign whose earlier test ended (this was the "campaign not selectable" bug that took several wrong guesses). "Not yet tested on" suggestions legitimately keep the all-legs exclusion.

Upload no longer silently defaults tech to Heat Pump (`UploadCreativeModal`); tech is editable post-upload via `useCreativeTests.setTech`.

4. **Merged vs per-campaign figures (2026-09-19, #827).** The creative-level `rank`/`suggestedVerdict`/CPLB is merged across all legs, fine ONLY for By-creative with all clients. Every campaign-level surface must use the leg's own `perCampaign[].rank` (ranked vs the campaign client's target): By-campaign board, Campaign breakdown list (CPLB column), and the client-filtered board (re-ranked via `t.viewOf(legs)`). Performance page is client-scoped by rows, never pooled. Charlotte: "merged values... client spec only" means never show another client's figures inside a client view.
