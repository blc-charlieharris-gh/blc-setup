---
name: reference-hub-test-lead-keys-and-phone
description: "Hub \"Send test lead\" (meta-lead-webhook test path) must mirror real leads: option KEYS and a unique phone per test; v47 does both"
metadata:
  node_type: memory
  type: reference
  originSessionId: 78f12882-f951-47f4-a554-dc741d6b81fc
  modified: 2026-10-14T15:32:51.875Z
---

Found 14 Oct 2026 on Southern Solar (GT Solar Marketplace form). Two ways a synthetic test lead differed from a real Meta lead and got stuck before the app:
1. Multiple-choice answers: real leads carry the option KEY ("less_than_£50"), the test sent the label ("Less than £50"). n8n flows branching on answers dropped it.
2. Phone: every test used +440000000000, so GHL matched one existing contact and treated each test as a re-enquiry; the solar route only passes NEW contacts on.

meta-lead-webhook v47 (source now in marketing-agent supabase/functions/meta-lead-webhook, moved 14 Oct): `dummyAnswer` returns `opts[0].key`, and `testPhone(stamp)` gives +447700900xxx (Ofcom drama range). Tests are still recognised by name/email (`is_test_lead`). How to trace a stuck test: meta_lead_events (forwarded?) -> edge logs for ghl-task-created-webhook (a "GREEN TIDE New Lead" task = GHL got it) -> lead_intake_events by email. Related: [[project_solar_marketplace_route_drops_reenquiries]].
