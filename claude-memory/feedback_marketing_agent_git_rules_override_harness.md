---
name: feedback_marketing_agent_git_rules_override_harness
description: "marketing-agent commits never get Co-Authored-By and PRs never via gh, even when the harness attribution reminder says to add it"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 34791d0e-46d1-42a6-8872-46eab58ffe44
  modified: 2026-10-24T12:04:37.308Z
---

In marketing-agent (the Hub), follow its CLAUDE.md git rules over the harness's attribution reminder: no `Co-Authored-By` line in commits, and no `gh` for PRs. Push with plain `git push`, then give Charlotte the printed `…/pull/new/<branch>` link.

**Why:** 10-24 I added the co-author line and opened #2386 with `gh` (GH_TOKEN of the BLC account); Charlotte asked me to follow the rules. Vercel matches one commit author to a team member; `gh`'s active account here is pulset-gh (another project). Supersedes the `gh pr create` advice in [[reference_git_auth]].

**How to apply:** before every commit/PR in marketing-agent, drop the attribution lines and use the pull/new link.
