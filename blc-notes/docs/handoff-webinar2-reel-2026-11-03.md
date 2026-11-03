# Handoff, 2026-11-03 (Webinar 2 reel ad)

## What we worked on
- A ~30s 9:16 Reels ad cut from `Webinar 2 VSL.mp4` (Brad, Warm Homes Loan Scheme webinar).
- Final: `Webinar 2 Reel 30s.mp4`, 29.8s, 1080x1920, about -14 LUFS.
- Script: hook (scheme is live), £14,000 upfront objection, four "can your surveyor / quoting tool / finance providers / marketing" questions, "who do you think is going to start winning these jobs?", "So if you want to fix those things, you can register for the live webinar on this page."
- Edit: face-tracked full-screen crop, punch-in zoom per sentence, VSL's burned-in captions painted out, new word-by-word captions (spoken word green), pulsing red "LAST DAY TO REGISTER" pill plus "INSTALLER WEBINAR WED 4 NOV · 6PM", end card. Music: Lyria 3 via `meta-access/access-videos/shared/music.py`, ducked under the voice.

## Current state
Done. Charlotte has the reel. Both videos were then moved to the macOS Bin (not deleted) and the working files were removed, so a re-edit means restoring the VSL from the Bin and rebuilding. The render scripts were not kept.

## Next steps
1. Switch the reel off or swap it after 3 Nov: "Last day to register" is only true today; webinar is Wed 4 Nov, 6pm.
2. Empty the Bin once the reel is in Meta.

## Decisions and open questions
- "next Wednesday" line left out of the cut so the reel does not date; date sits in the banner instead.
- Music made fresh with Lyria (second prompt asked for no ending; the first one finished at ~26s).

## Working tree and other sessions
Clean: no git repo changed, nothing deployed. Prime project and GHL/CRM sessions were told about the CHANGELOG entry. blc-setup has 5 uncommitted memory files from another session (left as is). Daily clean-up script: see the close.
