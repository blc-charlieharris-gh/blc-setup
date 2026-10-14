---
name: feedback_never_swap_client_web3forms_keys
description: "Handed-over client sites keep the client's own Web3Forms key; updates and audit fixes must never swap it for ours or another key"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 3f881c5f-f0a6-420d-b97b-044f8e7f15e0
  modified: 2026-10-14T09:26:21.924Z
---

Charlotte 2026-10-14 (Arktek / Retrofit / Renerji updated-files round): "make sure we do not swap out the client web3 form keys, the live version has the right one". Keys at that date: Arktek 143db407…, Retrofit c5c30c62…, Renerji e562af48…; the Hub audit check "Forms on the client's Web3Forms key" passes on all three.

**Why:** the live sites send leads to the client's own inbox; a swapped key silently sends their enquiries to us or nowhere.
**How to apply:** any change to a website-factory/clients/<slug> site that is (or was) handed over: grep access_key before and after and confirm byte-identical; never "fix" a key to an agency key. Only change a key when Charlotte asks for that specific change. Related: [[feedback_client_asks_after_site_ready_dns_handover]], [[feedback_website_factory_manual_deploy_gap]].
