---
name: project_webinar_deck
description: "Loan Scheme Ready webinar deck: source in git repo site-installrhub/installrhub-static/webinar-deck/ (git pull first), team link on internal.installrhub.com/present/, Brad's artifact is the wording source"
metadata:
  node_type: memory
  type: project
  originSessionId: 6c55e0d6-ba87-41a2-97b6-bcdbcd30f8c6
  modified: 2026-10-05T11:05:54.524Z
---

Source: git repo `site-installrhub/installrhub-static/webinar-deck/` — `git pull` before editing. (A stale untracked copy at `site-installrhub/webinar-deck/` was deleted 2026-10-05; if one reappears, ignore it.) (parts/01-05.html, deck.css, deck.js, build.py). Wording and slide order come from Brad's Slides artifact https://claude.ai/artifact/BERpMEhgFvoc4DTiJK1Vda (synced 2026-10-04). Team link: https://internal.installrhub.com/present/loan-scheme-ready-e43e96, pasted in Hub Events > Presentation slides. Republish: `python3 build.py --publish <marketing-agent>/public/present/loan-scheme-ready-e43e96`, then a Hub PR (no Co-Authored-By, no gh).

**Why:** decided 2026-10-04, renamed 2026-10-05: the call is the "30-minute Loan Scheme Growth Session" (was "Growth Plan"; deck, notes and /webinar/book-demo all say Session), while the Installer MOT is the scorecard/lead magnet. Since 2026-10-05 the presenter notes are Brad's own speaker script (pasted by Charlotte), slide 13 is his early pitch, and slides show no page numbers. The booking QR goes to /go/webinar-oct2026-demo-live, not Brad's /go/hsyrf5m (SMS tags). There is no PDF for attendees.

**How to apply:** when Brad changes wording, copy it from his artifact into parts/ and keep these deliberate differences. All placeholders filled and live 2026-10-05 evening (PRs site-installrhub #169, marketing-agent #1501): 22 GasWorx quote from their YouTube short, 28 SWH report on a tablet (ad spend always cropped out), 43 homepage testimonials as floating cards, 47 deadline midnight Fri 9 Oct. Andrew Smith's phone number in chat-confirmed.png is blurred (#170 / #1502). Charlotte drops new images in site-installrhub/deck/. gh CLI here is logged into pulset-gh, so for site-installrhub use GH_TOKEN from `git credential fill`; merging is hers. Bigger headshots (only 320px exist) still to do. Related: [[feedback_public_by_link_pages_rule]], [[feedback_marketing_agent_no_coauthor_no_gh]]
