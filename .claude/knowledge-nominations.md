# Knowledge Nominations

Candidate learnings awaiting auditor review and promotion to `knowledge-base.md`.

Any agent can append nominations here during any task.
Format: `- [CATEGORY] [MMDDYY]: {pattern description} — Observed: {evidence}. Impact: {what it affects}.`

The auditor reviews these during each `/audit` cycle and promotes confirmed patterns to the knowledge base.
A pattern must be confirmed across 2+ instances before nomination, and verified by the auditor before promotion.

---

## Pending Nominations
<!-- Add candidate nominations below -->

- [092826] /wrap-up: A page on another site does not send `SameSite=Lax` cookies, and `sec-gpc: 1` can still drop `SameSite=None` cookies. HttpOnly session cookies need a JS-readable token header plus `Authorization: Bearer`. | Evidence: `reserve.legendslimousine.com` to `legends.tripslink.com`; `sendCode` missing `websiteLoginToken`; profile 401 after verify; live `accessToken` lacked `SameSite=None` on `JDK14-414`.
- [092826] /wrap-up: `NOT USING HC` in `WebReqFactory.init` means the request had no JWT, not that the Hazelcast client is down. | Evidence: `tabJobsAction` log `NOT USING HC` when `tokenClientId` was null after login.
- [092826] /wrap-up: Re-applying a pickup that already has a street number clears it when place details return no building, and the later full save throws `Street # Required`. | Evidence: `Job.saveChanges` via `setJobReconfirmedByUser` from `BookingService.bookNewJob` on edit save.
