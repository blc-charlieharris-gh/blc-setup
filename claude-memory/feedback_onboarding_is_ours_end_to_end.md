---
name: feedback-onboarding-is-ours-end-to-end
description: "Client onboarding (invites, form, register-installer, generate-invite-token, emails) is BLC's to build and fix end to end, never \"Serafim's side\""
metadata:
  node_type: memory
  type: feedback
  originSessionId: 091d3959-9912-4d6b-8a11-180c9a2c135f
  modified: 2026-09-29T11:25:07.605Z
---

Client onboarding is ours end to end: the invite mint (generate-invite-token / send-onboarding-email), the public form at internal.installrhub.com/client-onboarding, the submit (register-installer), the onboarding emails and chasers. Don't park onboarding fixes as "for Serafim".

**Why:** Charlotte corrected this 2026-09-29 ("we handle onboarding end to end not serafim remember") after I labelled link expiry and saving answers as Serafim's. Those edge fns aren't in the marketing-agent repo, but the deployed copies can be read with the Supabase MCP (get_edge_function) and Charlotte pastes new versions, same as other edge fns (see [[reference-blc-supabase-cli-wrapper]]).

**How to apply:** plan and build onboarding changes ourselves, edge fns included (hand Charlotte a paste-ready single file). Open onboarding work, queued for the audit's Clients > Manage page (repo .claude/docs/hub-audit/README.md page 16): Copy link / our own short link on the client card, links that never expire, answers saved to the server as they go, one click minting two invites (the second lost the retainer details, Jones and Baker 28 Sep). Also: the 3rd onboarding email (sent when they've filled the form in) goes out hit and miss, find the trigger and make it reliable (Charlotte 09-29). Related: [[reference-onboarding-invite-consumed-at-ground-truth]].
