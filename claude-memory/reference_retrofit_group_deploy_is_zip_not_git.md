---
name: reference_retrofit_group_deploy_is_zip_not_git
description: "Retrofit Group's site deploys via zip handoff to client-managed Namesco hosting, not git push — client-sites/ is entirely gitignored"
metadata:
  node_type: memory
  type: reference
  originSessionId: 00e6c831-6b75-429d-9f72-ead139248104
  modified: 2026-09-03T14:31:16.170Z
---

Retrofit Group's static site (`marketing-hub/marketing-agent/client-sites/retrofit-group/site`, see [[project_retrofit_group]]) is NOT deployed by pushing to the `marketing-agent` git repo. Confirmed 2026-09-03: `git check-ignore -v` shows the entire `client-sites/` directory is gitignored, and `git ls-files` on the site folder returns zero tracked files. An earlier memory ([[project_retrofit_seo_audit_pending]], now corrected) wrongly assumed "pushing triggers the live deploy" — that applies to the website-factory Vercel-deployed sites (Arktek, SWH, Gas Worx, LW Heating), not this one.

The real flow: BLC edits the local working copy, zips it (matching the existing files-at-root structure, see any prior `retrofit-group-site-*.zip` in the same folder for the reference layout), and hands the zip to the client (historically via WeTransfer link in the email thread, not a Gmail attachment). The client uploads it themselves to their own Namesco Managed WordPress hosting (see [[project_retrofit_site_trustpilot_cd]] for the Varnish-cache gotchas that host has caused before). Nothing about editing this folder ever needs a commit, push, or PR, and editing it cannot collide with other sessions' work in the shared `marketing-agent` git working tree.
