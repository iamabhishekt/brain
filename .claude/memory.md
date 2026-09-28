# Memory

## Now
- Legends site `https://reserve.legendslimousine.com` calls `https://legends.tripslink.com/JLimoApi` cross-site.
- Session bearer fallback is pushed (`JLimoCore` `9be02db156`, `ReactJLimoWeb` `7f805798c`) and is not on live `JDK14-414`.
- Edit save still fails with `Street # Required`. The local preservation edit is not in the tree.

## Project
- **Name:** Sattvora Enterprises (Ecommerce Website)
- **What:** Ayurvedic healthcare & wellness ecommerce platform with full checkout flow & distributor panel
- **Frontend:** Located in `sattvora-frontend/` (React 19, Vite, Tailwind v4, TypeScript)

## Working Style
- Edit mode: agent writes code upon request.
- Phased execution: max 5 files per phase.
- Code quality: clean code, proper typing, test verification.

## Recent Decisions
- [092826] Legends CORS stays an allowlist. Custom domain is on `/**` only.
- [092826] Cross-site login sends `Authorization: Bearer` from response headers because `SameSite=None` cookies can still be dropped when `sec-gpc: 1`.
- Claudify OS installed into the Sattvora project. Frontend is in `sattvora-frontend/`.

## Open Threads
- Redeploy JlimoApi and the website bundle, then confirm logged-in `tabJobsAction` uses Hazelcast.
- Reapply pickup street-number preservation so edit save does not throw `Street # Required`.
- Sattvora backend and `App.tsx` split are paused.
