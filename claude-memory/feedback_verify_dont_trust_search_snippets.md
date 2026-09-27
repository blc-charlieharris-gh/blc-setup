---
name: feedback_verify_dont_trust_search_snippets
description: Never source a hard number in client-facing work from a search-engine summary; read the source directly with headless Puppeteer when WebFetch 403s
metadata: 
  node_type: memory
  type: feedback
  originSessionId: fedab6bd-5e7e-4b2a-8415-2394f51ca230
---

On the Stellar SiteScore ([[project_sitescore_stellar]]), Charlotte asked "where did you get their review from if it's not on the site? not saying it's wrong, just checking." It was wrong. The audit said **4.6 from 77 reviews**; the truth is **4.6 from 76**.

**What went wrong:** WebFetch to Trustpilot returned **403**, so the page was never read. The number came from a **WebSearch result summary**. Worse, successive searches returned **73, 76 and 77**, and that disagreement was resolved by silently taking the newest instead of treating it as the red flag it was. The report then claimed the figure was "verified directly against Trustpilot", which never happened. A single sceptical question from the user exposed it.

**Why:** these audits go live to prospects and their entire credibility rests on the verified/inferred line. A client who spots one wrong number stops believing the other forty. And "verified directly" is a claim in its own right, so it has to be literally true.

**How to apply:**
- **A hard number in client-facing work must come from the source itself, never a search snippet.** Search is for *finding* the source, not for reading it.
- **A failed fetch is not a soft signal.** If WebFetch 403s, the number is UNVERIFIED until read another way. Never let a search summary silently backfill a failed fetch.
- **Disagreeing sources = stop and verify**, never pick one. 73 vs 76 vs 77 was the tell.
- **Only write "verified" for things actually verified.** Attribute per-fact: TrustMark *was* read directly from the register; Trustpilot was not. Don't let one true verification launder an adjacent unverified one in the same sentence.
- **The technique that works** when WebFetch 403s (Trustpilot, Imperva/Cloudflare sites, cf. Gas Safe in [[reference_arktek_mcs_status]]): drive headless Puppeteer with a real UA, poll until the "Verifying Connection"/"Just a moment" title clears (~1.5s), then read the embedded **JSON-LD `aggregateRating`**, which is authoritative and machine-readable. Hide the cookie dialog with CSS rather than clicking it. Script: `meta-access/outputs/sitescore-stellar/verify-tp3.mjs`.
- Trustpilot profiles also expose useful nuance worth harvesting: "claimed since <date>", "No recent history of asking for reviews", "replied to X% of negative reviews". The review-invite notice is a genuine finding + retainer hook.

**RECURRING, HAS NOW BITTEN TWICE (Stellar #28→#29, Prime Energy #32→#33). Before saying an update shipped, run `gh pr view <n> --json state`.** Charlotte merges fast, often while the revision is still being written. A push to a branch whose PR has already merged **silently does nothing**: the commit is orphaned, main keeps the old version, and the push output still says success. `gh pr comment` on a merged PR also succeeds and looks fine. The recovery is always the same: fresh branch off the NEW main, copy the built file in, commit as a **modify** (`git diff --cached --name-status` must show `M`, not `A`, or GitHub throws a both-added conflict), new PR. Knowing this rule is not enough; the second time it happened the note already existed and was not followed. **Check the PR state, not the push output, every time.**

**Charlotte's "just checking" questions are worth treating as gold, not as challenges to defend against.** Two in a row on the Stellar audit ("where did you get their review from?", "where is info@stellarinsulation.com found?") each found something: one a wrong number, one an under-rated finding that DNS turned into one of the best in the report (see Fix 07 in [[project_sitescore_stellar]]). Re-derive the answer from the source rather than restating the claim.

**Generalisable audit technique that came out of this:** when a site shows two contact addresses/domains, check **MX + A records for both**. Different MX (e.g. Google Workspace vs Microsoft 365) proves they are genuinely separate inboxes, not aliases; and a domain that accepts mail never bounces, so enquiries can vanish silently. Also check whether a link's label is CSS-hidden: `innerText` misses it, so grep the raw HTML for `mailto:`/`tel:` and compare against the visible text, then verify clickability + bounding box in the browser.

Related: [[feedback_sitescore_dont_assume_the_service]] (same family: don't let a confident narrative outrun the evidence).
