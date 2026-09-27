---
name: feedback-audit-security-headers-attribution
description: "site-audit security_headers fail is usually OUR missing config, not the host; wrong host-blame reached the Arktek client 09-18"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d3093207-ac63-477f-a42a-2d70b1efb989
  modified: 2026-09-18T14:39:38.593Z
---

Arktek's security_headers fail was blamed on the host and Charlotte passed that to the client. Actually Arktek failed on Vercel too (hub audit 09-01, arktek-installrhub.vercel.app): its vercel.json never had a headers block. SWH (forked from Arktek) got headers at creation 08-25 (#669), never backported. ClientAuditSummary.jsx copy says headers are "controlled by whichever company hosts your site, not by us", which is false when we ship vercel.json/.htaccess.

**Why:** a wrong cause went to a client. Charlotte was rightly angry.

**How to apply:** before explaining any audit fail, check the `server` response header and our shipped config (vercel.json / .htaccess). Once a site moves to the client's host it is OUT OF OUR HANDS (Charlotte, 09-18), so the pre-handover audit is the final one: audit the handover build as the destination host will serve it (record host type, serve the zip under the same server software e.g. LiteSpeed/Apache container, built with SITE_URL=end_domain), and hard-fail missing host-specific config (.htaccess headers, Nginx snippet). Compare against the prior stored audit (hub_clients.audit) before attributing a change. Headers belong in every build for every host type. Related: [[feedback-diagnose-stated-symptom-not-substitute]]

**Repeat (09-22, Retrofit):** I told Charlotte "Namesco is nginx, ignores .htaccess, host must do it" from the `server: nginx` header alone. Wrong: error bodies were Apache's ("You don't have permission to access this resource", HTML 2.0 DTD) and etag was Apache format, i.e. nginx proxy in front of Apache, so .htaccess works. `server:` shows only the front proxy. Before saying "host issue", probe a 404/403 body + etag, and check whether the live site ever HAD a .htaccess (missing headers often just = no file shipped).

**Third time (09-22, Renerji CSP):** shipped a "light" CSP with no default-src, assuming any default-src meant a domain allowlist that would break third-party quote tools. Audit warns on missing default-src. Right answer: scheme-based default-src (`default-src 'self' https: wss: data: blob: 'unsafe-inline' 'unsafe-eval'; object-src 'none'; base-uri 'self'; frame-ancestors 'self'; upgrade-insecure-requests`), tested against the LIVE site by injecting the header via puppeteer request interception (tools behave identically, zero blocks). Read the audit check's code before choosing, and test on the real domain when widgets are domain-locked.
