---
name: reference-installrhub-domains
description: "InstallrHub surfaces — app.* (dashboard, live DB) vs www.* (public marketing site, separate build); public InsightsHub blog lives on www"
metadata: 
  node_type: memory
  type: reference
  originSessionId: d2dc718a-d398-4063-a361-62506810f62a
---

InstallrHub spans separate Vercel projects/surfaces that are easy to confuse (this confusion caused a blog go-live miss on 2026-06-04):

- **app.installrhub.com** = `installrhub-dashboard` project = the React dashboard/app (Green Tide Dashboard). Reads `blog_posts` from Supabase LIVE, so a published post appears with no rebuild. This is NOT the public-facing blog.
- **www.installrhub.com / installrhub.com** = `installrhub-site` Vercel project, repo `blc-charlieharris-gh/site-installrhub` (framework=null, NOT Next.js, so NO ISR/revalidatePath). Public blog served by `api/blog.js` at `/blog/*`. This is OURS, NOT Serafim's repo.
  - **2026-07-17 SHIPPED (PR #40): the JSON-sync model is DEAD.** The old "`blog-posts.json` committed by a sync job" story (and any advice to "re-run the sync") is obsolete and was the bug, not the fix. The hub moved blog storage to the Supabase `blog_posts` table but the renderer was never switched over, so the JSON froze at 5 posts while the DB reached 12 published: 7 posts had NEVER been live (back to 18 Jun). `loadPosts()` now reads `blog_posts` over PostgREST per request; the JSON is deleted. Publish is live instantly, no rebuild, no sync, nothing tied to Charlotte's Mac. Verified live: all 12 published resolve 200, drafts 404.
  - `SUPABASE_URL` + `SUPABASE_SERVICE_ROLE_KEY` are set on `installrhub-site` **Production only** (key is marked sensitive = cannot be pulled back, so it can NOT be tested locally and PREVIEW deploys of the blog will 503 until the key is added to preview too). Service-role is used because `blog_posts` RLS has NO anon read policy (only `authenticated` + `hub_can('blog')`); key is server-only, query pinned to published/approved, internal columns excluded. An anon SELECT policy was the rejected alternative (would need a Serafim migration).
  - **Env-var-before-merge is load-bearing**: #38 merged before the keys existed and 503'd the whole blog. Rollback lever = `vercel rollback`/promote the previous deployment, which needs no PR merge. Index only shows latest 3 + 3/category by design; don't read that as posts missing.
  - **`&nbsp;` between every word** (~1000/post) is the Google Docs paste signature and made text run off the page; it was in the DB all along but only shipped once the renderer read Supabase. PR #41 fixes it on READ (`normalizeContent()` collapses `&nbsp;`/U+00A0) rather than by rewriting rows, so drafting in Google Docs stays safe. `.post-content` also got `overflow-wrap: break-word`. Not all posts affected (pay-per-survey-model had 0), which is why a one-off data UPDATE was the wrong fix.
  - Dead local branch `chore/sync-blog-posts-from-supabase` (d4857b5, 12 Jun, unmerged, local-only) is the OLD sync-job approach. Obsolete: delete it, never revive it.
  - Renderer expects camelCase (`body`, `excerpt`, `coverImageUrl`, `scheduledDate`); DB is snake_case + a `meta` jsonb holding `ogTitle`/`ogImage`/`ogDescription`/`videoEmbed`/`focusKeyword`. `mapPost()` bridges them.
- **website.installrhub.com** = the `marketing-agent` Vercel project (this hub).
- **greentide.vercel.app / greentideenergy.com** = the Green Tide public site (see [[project-greentide-site]]).

When the public blog "isn't live," the surface to fix is **www**, not app. Verify with `curl -sL -o /dev/null -w "%{http_code}" https://www.installrhub.com/blog/<slug>`. If a post is missing, check its `status` in `blog_posts` FIRST: `pending_approval` posts need approving in the hub and are not a bug (12 were sitting unapproved on 2026-07-17). The meta-sync / agent edge functions live in Serafim's repo (deployed to the shared Supabase), not checked out on this machine; only Serafim deploys them. See [[feedback-serafim-signoff-and-handoffs]].
