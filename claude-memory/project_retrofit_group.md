---
name: project_retrofit_group
description: "Retrofit Group — BLC-managed Meta ad account, Scotland Central Belt solar lead-gen, ~£80 CPL"
metadata: 
  node_type: memory
  type: project
  originSessionId: d78970bf-5121-459a-bed6-e185ab65af73
---

Retrofit Group is a retainer client whose Meta ad account BLC runs (`act_1248074660642714`, GBP, in the meta-access token's scope). One ACTIVE campaign "BLC Solar Campaign" (id `120241594594330125`), OUTCOME_LEADS, instant forms, ~£52/day.

- **Geo:** hand-listed ~270 postcode sectors covering Scotland Central Belt + Ayrshire (G, FK, EH47-54/W.Lothian, KA, ML, PA), excludes Northern Ireland + Shetland. Meta region breakdown confirms ~100% delivery in Scotland.
- **True CPL ~£72-88** the whole time it has run (Apr 2026 on); it has NEVER been cheap. Count leads correctly per [[feedback_meta_lead_counting]].
- The "Retrofit Group" tag in the shared Supabase `lead_intake_events` is a *client-allocation* label, NOT an ad-source label — leads under it include non-Scottish/out-of-target postcodes, so don't use it to judge the ad campaign's geography.
- **Recurring failure mode (seen Jun 2026):** account gets torn apart by duplicating the ad set (resets learning to zero), pausing the proven winners, and leaving weak unproven "Test - image1" ads live → delivery stalls (£379 spend / 0 leads in a week). Fix = re-activate the original ad set (no learning reset on un-pause), pause the duplicate, keep the proven lead-getters live. Same "never duplicate ad sets" lesson as Green Tide.

**Re-audit 2026-09-22:** fixed files in client-sites/retrofit-group/site (gitignored) + retrofit-group-site-2026-09-22.zip (76 files). Live site = 07-30 zip. Host Namesco = nginx proxy IN FRONT OF Apache (Apache error pages + Apache etag format, 22-09 probe), so the shipped .htaccess should apply headers/www 301/404 itself. Earlier 'nginx ignores .htaccess' claim was WRONG (live site simply never had a .htaccess). Confirm with a live-target audit after client uploads; only ask Namesco if headers still missing. Preview project retrofit-group.vercel.app is on Charlotte's PERSONAL Vercel scope (charlieharris-4909s-projects), as is renerji. hub_clients id 'retrofit-group' had end_domain null; SQL to set retrofit-group.com + webform_transferred given to Charlotte.
