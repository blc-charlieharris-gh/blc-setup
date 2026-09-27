---
name: gasworx-mobile-slice-overlap
description: "build-pages.mjs slices reusable fragments out of template.html by byte range between markers; inserting new markup in template.html between those markers silently duplicates it into every generated page"
metadata:
  type: feedback
  originSessionId: c3b34899-d0f2-4b1c-b54f-61452cead0eb
  modified: 2026-09-04T16:13:58.690Z
---

`website-factory/clients/gasworx/build-pages.mjs` builds every generated page by slicing fixed byte ranges out of `template.html` (`head`, `navRaw`, `mobRaw`, `footRaw`, etc., via `tpl.slice(indexOf(from), indexOf(to))`) and reusing them as shared constants (`nav()`, `mobile`, `footer`) across all pages. `page()` then assembles `${nav(active)}${mobile}${body}...${footer}`.

Adding an accessibility fix (`<main id="main">` wrapping page content, 2026-08-18) to `template.html` right after the mobile-menu `</nav>` and before the `<!-- HERO -->` marker landed *inside* the exact range `mobRaw = slice('<nav class="mobile-menu"', M.hero)`. That made every OTHER generated page pick the tag up twice: once via the reused `${mobile}` fragment, once via `page()`'s own independent `<main id="main">` injection. Only caught by grepping open/close tag counts across all generated output files, not from template.html alone (which looked correct on its own since it's used directly, not run through `page()`).

**Why:** the marker-delimited slices are invisible in the source, there is no comment noting "this exact byte range gets reused elsewhere." Any edit to `template.html` between two `M.*` markers needs a check against where else that range gets spliced in.

**How to apply:** before editing `template.html` in this specific kit, `grep -n "M\.\|slice(" build-pages.mjs` to see the marker ranges, and place new structural markup either fully inside a marker's own section or fully outside all sliced ranges. After any structural edit, rebuild and grep tag-balance (open vs close count) across ALL generated pages, not just template.html, since template.html itself won't show a duplicate but pages built through `page()` will.

**Confirmed safe zone (2026-09-04):** the range between the `<!-- HERO -->` and `<!-- TRUST STRIP -->` markers is homepage-only, no `slice(M.hero, ...)` call captures it, so new markup placed there (used for [[project_gasworx_energy_savings_landing]]'s promo banner) appears only on template.html's own rendered output. Verified by running `node build-pages.mjs` and diffing every other generated page: they picked up zero markup, only the shared `<style>` block's new CSS (harmless, unused there). `navRaw`, `mobRaw`, `trust`, `svcGrid`, `process_`, `bookRaw`, `modalRaw`, and `footRaw` are the actually-shared ranges, listed at the top of `build-pages.mjs`; anything outside all of those is homepage-exclusive.
