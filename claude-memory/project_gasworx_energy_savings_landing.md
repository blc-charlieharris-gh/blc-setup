---
name: project_gasworx_energy_savings_landing
description: "Gas Worx energy-savings ad landing page + homepage promo banner (2026-09-04) — live, funnel is a click-through mockup, no bill-scan engine or Calendly embed yet"
metadata: 
  node_type: memory
  type: project
  originSessionId: e1d1c92c-a0bf-4805-8536-1cd9ac98343d
  modified: 2026-09-05T08:24:37.621Z
---

New standalone page `website-factory/clients/gasworx/energy-savings.html`, a heat pump/battery/
solar savings ad landing page. Built from scratch (not from [[project_gasworx_website]]'s
`gasworx-ecosystem` Base44 React scaffold, which was explored for content/logic reference only and
left untouched/unused). Matches the real site's design system exactly, including live-pulled
computed values off gasworx.vercel.app (h1 `clamp(2.3rem,4.6vw,72px)` weight 700, 1816px container,
48px gutters) rather than guessed ones.

**Structure: 3-step funnel, one page, staged reveal** (Charlotte's explicit call over either a flat
multi-CTA page or literal separate URLs): `#bill-upload` (dropzone + manual entry form, visual
mockup, no calculation wired) → `#book-appointment` (mockup card, no calendar embedded) →
`#thank-you`. Deliberately inert past the mockup UI, on purpose, to test the funnel shape/copy
before building the real bill-scanning engine (would reuse `BillUploadSection.jsx`'s extraction
prompt/JSON schema, ported off Base44's SDK onto a Supabase edge fn + OpenRouter, matching this
repo's existing AI pattern) and embedding a real Calendly widget.

**Homepage also touched:** added a lead-magnet promo strip to `template.html`'s homepage, between
the `HERO` and `TRUST STRIP` markers, a range `build-pages.mjs` never slices into other pages, see
[[feedback_gasworx_mobile_slice_overlap]] for why that specific range is the safe homepage-only
insertion zone. Also removed the video-camera icon from the nav/hero/footer CTAs site-wide (shared
slices) and added a second homepage-hero button linking to the new landing page.

**Copy/CTA state, after several rounds of correction:** hero = "Talk to an expert" (tel: link) +
"Get your free savings report" (`#bill-upload`), no icons; header/footer = single "Get Your Free
Report" button (`#bill-upload`); zero phone number displayed anywhere on the landing page (only
reachable via the "Talk to an expert" button's tel: href). See
[[feedback_confirm_which_page_before_implementing]].

**Status:** deployed live via `vercel deploy --prod` (gasworx.vercel.app has no git integration,
matches [[project_gasworx_website]]'s existing manual-deploy practice) and verified via curl after
each push. Merged to main 2026-09-04 as squash-merge PR #752 ("Feat/gasworx landing") — content on
main confirmed byte-identical to the branch tip via diff, not by ancestry (squash merges break
`git merge-base --is-ancestor`, see [[feedback_squash_merge_hides_from_commit_match]]). Branch
`feat/gasworx-landing` (local + remote) and its isolated worktree `.claude/worktrees/gasworx-landing`
were deleted/removed 2026-09-05, cleanup done.

**Audit 2026-09-21: still nothing wired, and NO lead capture at all.** Upload ignores the file and opens the manual form; manual form computes nothing and shows no result; "Book My Free Call" just reveals the thank-you ("we've got your details", which is false, no name/email/phone is ever collected). Hero "Talk to an expert" removed 09-21 (savings report is now the only hero CTA), Terms/Privacy/Cookies added to footer (branch `feat/gasworx-pricing-aircon`).
Client's Base44 app (`gasworx-ecosystem/`) for reference: AI bill read via Base44 `InvokeLLM` (needs their Base44 backend), savings = flat 31% of electricity + 78.6% of gas (one case study, upload path ignores gas), on-screen report (annual/10-yr saving, CO2, chart), then an external Calendly link `calendly.com/team-eco/45min` (45 min; our page says 15). It also never captures contact details. Verify the Calendly account is actually Gas Worx's before using it.

**WIRED UP 2026-09-21 (branch `feat/gasworx-pricing-aircon`, not yet merged/deployed):** upload removed, manual form (electric monthly bill required, unit rate/usage/gas optional, plus name/email/phone/postcode) posts to Web3Forms with the main site's key `fc2dfe40...`, then reveals Gas Worx's Calendly (confirmed theirs: "Introduction or Proposal call, Gas Worx Southampton Ltd", 45 min) prefilled with name/email. `calendly.event_scheduled` postMessage, or the "Skip this step" link, goes to new `energy-savings-thank-you.html` (`?booked=1` switches copy). Reframed as "personalised savings findings" talked through on a call, no on-page savings figure by choice (the only formula is the one-case-study 31%/79% ratio). Which inbox the Web3Forms key delivers to is unverified.

**LIVE 2026-09-21** via #860 + manual deploy. Later additions: form swipes to Calendly in one card with a 3-step tracker, booking summary email sent from the thank-you page (details, savings shown, Calendly event details, UTMs), `?demo=1` savings preview on preview hosts only. Outstanding: client to create a dedicated Calendly event with the redirect, then swap its link into `data-base`; Web3Forms key still ours.

**REDESIGNED 2026-09-21 (branch feat/gasworx-savings-spruce): the bill form is GONE.** Charlotte chose Gas Worx's Spruce heat pump estimate (`app.spruce.eco/gas_worx/embed`, loaded on "Start my estimate") with results hidden until a call is booked. Mechanism: Spruce postMessages `spruce_customer_requested_estimate` (after the customer details step, just before results) and the page hides the iframe instantly and slides to Calendly; `calendly.event_scheduled` reveals the results in place. The Spruce iframe must never be moved/removed (reloads, results lost). Spruce captures the lead, Calendly emails bookings; no Web3Forms, no savings formula, no thank-you page, no Calendly redirect needed. Full list of Spruce messages: grep `window.parent.postMessage("spruce_` in their bundle. Calendly can't be prefilled (details are inside Spruce).

**v2 same day (branch fix/gasworx-savings-flow-v2):** Spruce shows 'Estimated savings' (heat loss kW + a saving) on the SAME screen as its details form, so results can't be hidden without hiding the lead form. Flow is now: Spruce questions + headline saving + details (lead) -> Calendly -> our own 'You're booked in' confirmation (Spruce's thank-you screen hidden). **Spruce 'Auto send installer estimate' is a Spruce-staff admin feature flag (sits beside Account manager / Paid API endpoints in their admin panel), NOT a setting the installer can switch.** Ask Gas Worx what happens after a request, never tell him to toggle it.
