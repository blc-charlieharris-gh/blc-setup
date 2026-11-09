---
name: feedback-not-paid-holds-only-launch
description: "Not paid clients are not held back in any way except launching (Take live, launch question, campaign-live email, marketplace survey order)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 45e09088-2daa-422d-8ade-760797d5e08e
  modified: 2026-11-07T20:21:28.443Z
---

A client marked Not paid (lib/notPaid isNotPaid) is treated exactly like a paid client except launching: Take live / Live is refused, the portal "Ready to launch?" and campaign-live email wait, take-live Actions cards wait, and recording a marketplace survey order (switches direct booking on) waits. Builds, board columns, welcome email and chasers, the whole portal (ads to approve, order, catch-up, uploads), Email client, Actions chase cards, Crew jobs and brand kit tasks all go ahead.

**Why:** Charlotte 11-07: "i asked in the other session to not hold a not paid client back? only thing we dont do is launch". Britvolt's ads were hidden from their portal from 29 Oct because Not paid held the ads section; the older rule (10-01 "we do not manage this client in any capacity until paid") is reversed.

**How to apply:** never add a new Not paid hold except on a launch/go-live path; the fix branch was fix/not-paid-only-launch-1107. App-owned readers (welcome-email-gate, register-installer, apply-company-packages) go to Serafim. Related: [[feedback-whole-impact-before-any-change]]
