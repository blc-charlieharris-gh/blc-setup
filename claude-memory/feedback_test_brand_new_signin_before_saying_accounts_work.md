---
name: feedback_test_brand_new_signin_before_saying_accounts_work
description: "Before confirming client logins work, walk a brand-new person's FIRST sign-in end to end, not a returning login or mock data"
metadata:
  type: feedback
---

2026-10-15: Charlotte asked several times, before emailing clients the portal, whether their accounts worked. I'd only tested returning sign-ins and the mock preview. A brand-new person's first magic link was a "new account" link the confirm page rejected, so Sophie (LJP), Arktek and Paige (SWH) each had their first link fail after her email went out. "i asked several times before i sent that email out that their accounts work".

**Why:** a client-facing email is one shot; the first click is what clients judge.

**How to apply:** when she asks "do accounts work / is it ready to send", test every path a recipient can hit on day one: a person with no login yet, an unconfirmed login, a returning login, an invite, a staff view. Use a fresh test address on the live site (or check auth logs for a real first sign-in succeeding), and say exactly which paths were tested. If a path can't be tested, say so before she sends. Related: [[feedback_client_facing_means_portal_full_sweep]], [[feedback_build_check_every_pr]]
