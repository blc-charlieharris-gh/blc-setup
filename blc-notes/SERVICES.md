# BLC service registry

No credentials in this file. Names, non-secret IDs and rules only.
Last verified 2026-09-23.

## Rule for every entry
Before any write, deploy, send or publish: state the exact target out loud, confirm it matches
the row below, then act. "It is linked" is not proof of anything.

## In use

### GitHub
- Targets: `blc-charlieharris-gh/site-greentide`, `/internal-installrhub` (ARCHIVED, read-only),
  `/site-installrhub`, `/installrhub-creative-library`, and `serafimparente-blc/marketing-agent`
- Identity: `gh` OAuth as `blc-charlieharris-gh`, wired into git via a global credential helper
- Scope: ACCOUNT-WIDE. One token reaches every repo the account can see, including Serafim's
- Config scope: machine-global (`~/.gitconfig`, `~/.config/gh`). No SSH keys exist
- Pre-write check: `git -C <dir> remote -v`. Confirm the owner before any push
- Limitation: no per-repo isolation. Deploy keys over SSH would fix it; not done

### Vercel
- Team: `blc-promotions` (`team_m9xQUNOLcOucXiuPFpjnK04e`) holds 8 projects:
  greentide, marketing-agent, crew, installrhub-site, installrhub-portfolio, gasworx,
  swh-electrical, arktek, and now renerji
- Personal account `charlieharris-4909s-projects` (`team_g1OOu2NFzLDXsaVfhgh30FEz`) still holds:
  `retrofit-group` (transfer pending), `offer-remap-temp` (to be deleted)
- Identity: CLI OAuth as `charlieharris-4909`, a PERSONAL login, not a business one
- Scope: account-wide across both teams. Config is machine-global
- Default scope: corrected 2026-09-23 from personal to `blc-promotions`
- Pre-write check: read `.vercel/project.json` and confirm `orgId`, or pass `--scope` explicitly
- Note: `installrhub-portfolio` auto-deploys on push to its repo's main
- Limitation: business infrastructure runs on a personal login. Offboarding risk

### Supabase
- Project ref: `ozmyjrzleejbqxqphbut` ("InstallrHub"), org `xfburknuysbmpwnglhjc`
- SHARED PRODUCTION, used by both BLC and Serafim
- Access: MCP server, pinned `--read-only --project-ref=ozmyjrzleejbqxqphbut`
- Scope: the management token is account-wide; the service-role key bypasses RLS
- Pre-write check: confirm the project ref. Never call reporting RPCs raw through MCP;
  they go through rpcTimeout/rpcCached for a reason
- The CLI is not installed. `supabase/.temp/linked-project.json` is a stale record, not a link

### Meta Marketing API
- Ad accounts by name in `meta-access/.env`: Green Tide, Green Tide Backup, Retrofit Group,
  Renerji, My Eco Move, My Energy Care, Eco Green Upgrades. InstallrHub's is NOT in that file
  and must be passed explicitly
- Scope: BUSINESS-MANAGER-WIDE. One token reaches every ad account, Page and Instagram account
- Pre-write check: echo the resolved `act_` id AND the client name, and get confirmation.
  Activating ads spends money. Targeting edits reset learning and re-review every ad in the set
- Limitation: no per-client scoping. System users per ad account would fix it; not done

### Resend
- Sends real email to a real list. Domain `mail.installrhub.com`, low-volume, rate-capped
- Pre-write check: confirm recipient list and sending domain before any send

### GoHighLevel
- InstallrHub sub-account, location pinned via `GHL_INSTALLR_LOCATION_ID`
- This is the mailing list of record. The Hub mirrors it hourly at 17 past
- IMPORTANT: the mirror is up to 60 minutes stale. Run "Sync now" in
  Hub > Emails > Mailing list before any broadcast if GHL has just been pruned

### Others in use
Web3Forms (per-client keys; never ship ours in a client site) · OpenRouter · Anthropic API ·
Firecrawl · Twilio (via the dialer, real calls and real money) · Higgsfield (billable) ·
Canva · Google Drive and Gmail

## NOT used. Do not authenticate or configure these from this project.
- Netlify
- Cloudflare Workers, D1, R2 (Cloudflare IS the DNS for installrhub.com; no compute)
- Stripe (note: CREW is a subscription product, so this may change)
