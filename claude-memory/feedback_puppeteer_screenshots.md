---
name: puppeteer-screenshots
description: "SiteScore screenshots are automated via Puppeteer (already in workspace), not hand-captured or a paid API; reuse it for Crew audit shots + PDF rendering"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d7f4619a-b326-408f-a1d0-4937bf075174
---

The existing InstallrHub **SiteScore** screenshots (e.g. `site-installrhub/installrhub-static/sitescore/*`, outputs in `meta-access/outputs/sitescore-*`: `desktop-full.png`, `desktop-hero.png`, `mobile-hero.png`) are **automated headless-browser captures, NOT hand-captured and NOT a paid screenshot API**. Charlotte corrected me firmly on this.

**Why:** I assumed they were manual and recommended a paid service (screenshotone) for the Crew audit. Wrong. Puppeteer is already installed at `site-greentide/post-booking/node_modules/puppeteer` (full Puppeteer with bundled Chromium).

**How to apply:**
- For Crew audit screenshots (the screenshot-rich [[project_crew_workspace]] SiteScore) and for rendering docs to PDF, **use that Puppeteer, no paid service**. It needs a browser runtime, so it belongs in a worker/local process, not a Vercel serverless fn (which is why `api/crew-audit.js` has only an optional screenshotone hook).
- PDF rendering pattern that worked: a CommonJS script `require('<abs path>/site-greentide/post-booking/node_modules/puppeteer')` (ESM `import` from /tmp fails module resolution), `page.goto('file://...')`, `page.pdf({format:'A4', printBackground:true})`. Produced `CREW-Build-Status.pdf`.
