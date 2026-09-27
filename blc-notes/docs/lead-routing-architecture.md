# Lead routing architecture (all sites)

**Status as of 2026-08-05: built, correct, and switched OFF.** Every site falls back
to a hardcoded or env URL because the shared password table is empty. Fixing that
is three one-time moves, listed at the bottom.

Applies to: `site-installrhub`, `site-greentide`, and every future client landing
page. They all run the same `lookupRoute()` function, same env var names, same RPC.

---

## How it is supposed to work

A lead form does not know where it sends leads. It knows its own **form key**
(e.g. `installrhub-resources`). At submit time the site asks the database "where
does this key go?", and the hub's **Lead Intake > Landing page forms** screen owns
the answer.

```
form on the page
  -> POSTs { form_key, ...fields } to the site's own API route
     -> lookupRoute(form_key)
        -> RPC landing_route_lookup(p_form_key, p_secret)
           -> checks p_secret against landing_route_lookup_keys   <-- LOCK 2
           -> returns landing_form_routes.destination_url WHERE active
     -> POSTs the lead to that URL (n8n -> GHL)
     -> on ANY failure: Resend email to the team, never drop the lead
```

The point: **the destination is data, not config.** Change it in the hub, it takes
effect within 60s (module cache TTL). No developer, no redeploy, no env var.

## Why it is currently off

Two independent locks, both must be open. Either one shut means the site silently
falls back to env, and nobody notices because leads still arrive by email.

**Lock 1 (per Vercel project): the site never even asks.**
`lookupRoute()` opens with:
```js
if (!base || !anon || !secret) return { url: null, secret: null };
```
Needs `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `LEAD_ROUTE_LOOKUP_SECRET`. Miss any one
and it returns null without touching the network.

**Lock 2 (once, globally): the request would be refused.**
`landing_route_lookup` raises `unauthorized` unless an ACTIVE row in
`landing_route_lookup_keys` matches the secret. That table has **0 rows**, so it has
rejected every call from every site since it was created.

## Why nobody noticed

Every handler is deliberately built so a routing failure never loses a lead. That
is correct behaviour, and it is also why this hid for so long:

| Handler | Fallback chain |
|---|---|
| `site-installrhub/api/lead.js` (/forecast) | route -> env -> **hardcoded URL in the file** |
| `site-greentide/site/api/lead.js` | route -> `LEAD_WEBHOOK_URL` env |
| `site-installrhub/api/contact.js` | route -> per-form env -> **`''`, so email fallback** |

`/forecast` looked healthy because of its hardcoded URL. The forms on `contact.js`
had no hardcoded URL and no env set, so they went straight to the email fallback.
Same broken lookup underneath all of them.

See also: `feedback_silent_fallbacks_hide_dead_features` in memory. Check the CATCH
path first.

---

## The fix: three one-time moves

**1. Create the shared password (once, globally).** Any active row works for every
site, because the RPC only checks that the secret matches SOME active row.

```sql
insert into landing_route_lookup_keys (name, secret, active)
values ('blc-sites', '<generate a 32-byte random secret>', true);
```

**2. Add two env vars per Vercel project** (Production), once per project, forever:

| Name | Value |
|---|---|
| `LEAD_ROUTE_LOOKUP_SECRET` | the secret from step 1 |
| `SUPABASE_ANON_KEY` | the project's legacy `anon` JWT |

`SUPABASE_URL` is usually already set. Redeploy after, env vars only apply to new builds.

**3. Tick `active` on the routes.** The RPC filters `WHERE r.active`. An inactive
row returns nothing and falls through to env, which looks exactly like a
misconfiguration.

## Adding a form after that

1. Build the page and its form. Post `{ form_key, tracking, ...fields }`.
2. Register the key in the site's form registry (`api/_forms.js` on installrhub).
   This is also what puts it in the hub's dropdown instead of a free-text box where
   a typo fails silently.
3. Set its destination in the hub, and tick active.

Step 3 needs no deploy. Steps 1-2 ship with the page you were deploying anyway.

## Gotchas worth knowing

- **`active=false` and "no route configured" are indistinguishable** from the site's
  side. Both fall through to env. Check the tick first.
- **The 60s module cache** means a hub change takes up to a minute on warm lambdas.
- **A 200 from n8n does not mean the lead was mapped.** If the workflow accepts the
  payload but reads field names that are not there, it succeeds and drops the data,
  and the email fallback does NOT fire. Verify in GHL, not in the logs.
- **Field names are a contract with n8n.** When replacing a Fillout embed, keep the
  names the workflow already reads or the mapping breaks silently.

---

# Staged rollout

Agreed 2026-08-06. Ordered so InstallrHub and Green Tide are minimally exposed:
nothing that could drop a lead moves until the layer beneath it is proven.

Ground rule for every stage: **the email fallback stays in place throughout.** A lead
can arrive in the wrong place, it can never be lost.

## Stage 0 — turn the mechanism on (Charlotte, no code)

The three moves: one key row, two env vars per project, redeploy both.

- **Impact on live sites:** none. Every current fallback still works, so nothing changes
  for a visitor whether this succeeds or fails.
- **Risk:** none. Purely additive. If the secret is wrong the sites behave exactly as
  they do today.
- **Blocks:** everything below.
- **Verify:** probe each site's lead endpoint and confirm a resolved destination, then
  check the lead reaches GHL with fields populated (not just a 200).

Green Tide's in-house forms stay behind the kill switch throughout. Fillout keeps
serving both pages, so Green Tide carries zero risk in this stage.

## Stage 1 — make failure visible (hub only, read-only)

Show "last lead received" per route on Lead Intake > Landing page forms, derived from
data we already hold. A route with a destination and no lead ever is the signal that
something is misrouted.

- **Impact on live sites:** none. No site code changes.
- **Risk:** none. A read-only panel change.
- **Why before the code work:** today all three misconfigurations look identical from
  outside, because leads still arrive by email. Fix the blindness before changing the
  thing you are blind to.

## Stage 2 — one shape across both sites (code)

A shared helper used by `api/lead.js` and `api/contact.js` on both sites:

```
route lookup  ->  per-form env fallback  ->  email, and record that it fell back
```

Delete the hardcoded URL from InstallrHub's `api/lead.js`.

- **Impact:** `/forecast` starts obeying the hub instead of the URL baked into its
  source. That is the point, and it is also the only behaviour change in this stage.
- **Risk:** real but contained. **Only do this once Stage 0 is verified**, because the
  hardcoded URL is what keeps `/forecast` alive today. Removing it while the lookup is
  dead would push forecast leads to email.
- **Verify:** submit through `/forecast` and confirm the lead still lands, then repoint
  its destination in the hub and confirm the change actually takes effect.

## Stage 3 — client-agnostic by construction

- `form_key` convention: `<client-slug>-<form>`, e.g. `gasworx-solar`.
- Every site carries a registry (`api/_forms.js`), which already populates the hub
  picker and prevents silent typos. Green Tide needs one; InstallrHub has one.
- No client-specific code anywhere. A new client's form is data.

- **Impact:** none on existing forms, existing keys keep working.
- **Risk:** low, additive.

## Stage 4 — wire it into onboarding

Two changes, both app-side, so Serafim owns them.

1. **`lead_intake` becomes auto-derived, not a tick.** Green only when the client has an
   active route with a destination AND at least one lead received against it. Today
   someone can tick "lead intake tested" for a client whose form has no route, and the
   client reads as ready while their leads go to email. That is exactly the failure we
   have just spent a day on, waiting to repeat per client.
2. **Route rows minted on go-live**, keyed `<client-slug>-<form>`, attached to
   `client_id`, destination blank and `active=false`. It then shows in the hub as an
   obvious to-do, and a form can never ship without its route existing.

- **Blocked by:** the retainer-close bug. Closing a deal does not create the
  `client_onboarding` row today, so there is nothing to hang route creation off.
- **Verify:** onboard one client end to end and watch `lead_intake` go green on its own.

## What a new client looks like when this is done

1. Deal closes as retainer, onboarding row created
2. Route rows appear automatically, blank destination, flagged outstanding
3. Someone pastes the n8n URL and ticks active. No code, no deploy, no env var
4. Their form posts its `form_key`, the site asks the hub, the lead routes
5. First real lead arrives and `lead_intake` goes green by itself
