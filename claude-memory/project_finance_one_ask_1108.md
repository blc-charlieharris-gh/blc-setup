---
name: project_finance_one_ask_1108
description: Client finance is asked once; lib/financeApproval is the one answer; own brand gets everything, marketplace with no brand package yes/no only
metadata:
  type: project
---

Finance (live 11-08, #3374 #3379): one Finance section on onboarding; wording pasted there counts as approved; otherwise the portal card (`lib/financeApproval`, kind finance_approval on client_onboarding.info_requests). Ads use approved wording only, else general. Website sign-off holds until approved (site-feedback). 0% upfront ads only for clients who said yes; not answered = no.

**Why:** Charlotte: marketplace clients advertise under Green Tide unless they have a brand package, so they only need finance yes or no; own-brand clients need all of it. "It needs simplifying and unifying."

**How to apply:** read approval through `financeApproved(list, company)`, never `data.wording` or the form box. Company details is the one place to ask. Client account data tidiness goes in Client clean-up (`lib/clientCleanup`), ads tidiness in Library clean-up; access, payment and approvals stay on the board. Related: [[feedback_no_parallel_copies_of_one_job]].
