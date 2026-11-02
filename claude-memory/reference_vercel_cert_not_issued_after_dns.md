---
name: reference_vercel_cert_not_issued_after_dns
description: Vercel may never issue the SSL cert when a domain is added before DNS points at it; https dies with SSL_ERROR_SYSCALL while http 308s
metadata:
  type: reference
---

Gas Worx (2026-11-02): gas-worx.co.uk added to the blc-promotions `gasworx` project on 29 Oct, DNS moved at Wix later. Vercel showed verified, misconfigured false, but no cert in `certs ls`; https failed (curl SSL_ERROR_SYSCALL), plain http 308'd to www.

Fix: Charlotte runs `~/code/blc-setup/bin/blc-vercel certs issue <apex> <www> --scope blc-promotions` (Claude's run is refused as a cert change, see [[reference_blocked_actions_give_command]]). Renewal is automatic after that.

Diagnose read-only: `dig` A/CNAME/CAA, `blc-vercel api /v6/domains/<d>/config`, `blc-vercel certs ls | grep <d>`.
