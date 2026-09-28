# Task Board

## Today
- Redeploy JlimoApi past `JDK14-414` and the website bundle so `reserve.legendslimousine.com` keeps the login session.
- Re-apply the pickup street-number preservation in `BookingService.applyAddress`. The edit was not in the tree at wrap-up.
- After deploy, confirm a logged-in `tabJobsAction` logs `USING HC` with a `PLINK_` or `WEB_` id.

## This Week
- Check remaining Legends domain gaps: `/tripStat/**` CORS, Apple/Google Pay merchant domain `reserve.legendslimousine.com`, passkeys still bound to `legendsweb.cw.tripslink.com`.

## Backlog
- Sattvora: backend (orders, payments, database) and split `App.tsx`. Paused while Legends production login is open.

## Done
- [092826] CORS allow `https://reserve.legendslimousine.com` on JlimoApi `/**`.
- [092826] Cross-site `websiteLoginToken` cookie (`SameSite=None; Secure; Partitioned`).
- [092826] Access and refresh cookies use seconds and HTTPS `SameSite=None` (`a93cad3ddf`, `a0888e9253`).
- [092826] Login returns `Api-Access-Token` / `Api-Refresh-Token`; website sends `Authorization: Bearer` (`9be02db156`, `7f805798c`).
- [092826] Hazelcast client resolved live per call (`0b576d5a15`).
