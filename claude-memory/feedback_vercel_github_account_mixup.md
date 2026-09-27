---
name: feedback_vercel_github_account_mixup
description: "A Vercel PR deployment got blocked saying blc-charlieharris-gh had no linked Vercel account, real cause was a personal Vercel/GitHub account mixup, not a permissions loss"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 9c6e7f66-dfcd-4521-867d-936b0a4d3bfd
  modified: 2026-08-21T07:30:19.238Z
---

2026-08-20/21: a docs-only PR in marketing-agent got its Vercel preview deployment blocked with
"blc-charlieharris-gh does not have a Vercel account linked to their GitHub account." Charlotte had
set up a separate personal Vercel account the night before, on a different machine, and that GitHub
OAuth flow is what actually broke the link, not any real loss of BLC access or permissions. Being
logged into the correct BLC Vercel account AND the correct BLC GitHub account on the working machine
did not fix it, the check is server-side against the GitHub identity's global Vercel-account link,
independent of which browser session is active locally.

**Red herring along the way:** the "connect your GitHub account to Vercel" flow surfaced an unrelated
looking `admin@pulset.co` account, which briefly looked like a genuine third-party/security concern
worth stopping on. Turned out to just be Charlotte's own other account (for her personal project),
picked up because she was logged into both identities in the same browser. Worth pausing on that
kind of surprise regardless, since it usually IS worth verifying, but don't assume it's automatically
sinister once the account owner confirms it's theirs.

**Actual fix:** adding `blc-charlieharris-gh` back as a member of the BLC Vercel team cleared it.
Vercel's own message afterward: "The user is now a member of your team. This deployment can be
redeployed."

**How to apply:** if a Vercel deployment ever blocks again with this exact "commit author has no
linked Vercel account" message, don't assume BLC access was revoked. Ask whether a new personal
Vercel/GitHub connection was made recently, on any machine, that's the far more likely cause than
anything changing on BLC's side. The fix is on Vercel's team-membership page, not a git/GitHub
permissions fix.
