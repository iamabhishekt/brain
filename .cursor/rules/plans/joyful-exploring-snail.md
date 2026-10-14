# Plan: Apple Pay & Google Pay for TabJobs (Multi-Trip)

## Context

TabJobs currently supports CC, Cash, and Account FOPs. `AcctRequirementNew` (single-trip) already supports Apple Pay (`AP`) and Google Pay (`GP`). The user wants the same wallet options inside `TabJobsCC.jsp`'s `#fopDropdownTabJobs`, with the ability to charge for multiple trips.

## Problem

The existing multi-trip charge flow (`processTabJobsCcAfterSave` → `processMultiTripSale`) uses standard credit-card processing (`ProcessCC_v2_05.processPreAuthOrSale`), which does **not** support wallet tokens. Wallet pay is currently handled only for single jobs via `ProcessCcWebSrvc.processWalletPay(jobId, …)`, which performs a single PREAUTH/SALE on one job.

Therefore, adding AP/GP to TabJobs requires:
1. Frontend UI changes to expose wallet options.
2. Backend changes to accept AP/GP as `fopMode` during `saveTabJobs`.
3. A **new** multi-trip wallet charge path that runs a single wallet SALE for the aggregate amount and splits the charge across all saved jobs via `JobCharge` records.

## Recommended Approach

### Phase 1 — Frontend: Add Wallet Options to TabJobs Dropdown

**Files:**
- `JLimoCore/JlimoWeb_Core/src/main/resources/META-INF/resources/includes/TabJobsCC.jsp`
- `JLimoCore/JlimoWeb_Core/src/main/resources/META-INF/resources/js/quickReservation/tabJobs.js`

**Changes:**
1. In `TabJobsCC.jsp`, add `<li>` items for `AP` and `GP` inside `#fopDropdownTabJobs`, gated by `wfv.isUsingApplePay()` / `wfv.isUsingGooglePay()` (same pattern as `AcctRequirementNew.jsp`).
2. In `tabJobs.js`:
   - Extend `switchTabJobsFop` with cases for `AP` and `GP`.
   - When selected, hide the manual CC form, hide card selectors, and set `tabjobsFop = 'AP'` or `'GP'`.
   - Compute the aggregate due amount (sum of all visible tab jobs) and set `ApplePay.storedDueAmt` / `GooglePay.storedDueAmt` so the wallet sheet shows the correct total.
   - Reuse the existing `BookWithApplePay.js` and `BookWithGooglePay.js` utilities. They look for buttons with IDs `applePaySelectorButton` / `googlePaySelectorButton` or data attributes. We can embed minimal button markup (or hidden trigger elements) in `TabJobsCC.jsp` so those utilities find them.

### Phase 2 — Backend: Accept AP/GP in `saveTabJobs`

**File:**
- `JLimoCore/JlimoWeb_Core/core/src/com/limosys/jlimoweb/servlets/QuickReservation.java`

**Changes:**
1. In `saveTabJobs`, add explicit cases for `AP` and `GP` in the `fopMode` switch (around line 8273):
   ```java
   case "AP":
       fop.setFopCode("AP");
       break;
   case "GP":
       fop.setFopCode("GP");
       break;
   ```
   This prevents them from falling through to the `CC` default path, which tries to read `fopDisplNum` / `CC-MODE`.
2. Ensure `processTabJobsCcAfterSave` does **not** treat AP/GP as cash/check. The existing `isCheckoutCcFop` already includes `FopType.isAppleOrGooglePay`, so it will proceed to the charge branch.

### Phase 3 — Backend: Multi-Trip Wallet Charging

**File:**
- `JLimoCore/JlimoWeb_Core/core/src/com/limosys/jlimoweb/servlets/QuickReservation.java`
- `JLimoCore/JlimoDataLibrary/src/com/limosys/dblib/cc/ProcessCcWebSrvc.java`

**Changes:**
1. In `QuickReservation.java`, create a new private method `processMultiTripWalletPay` that mirrors `processMultiTripSale` but for wallet payments:
   - Takes the saved `htResults`, `dueAmt`, `savedJobsDueAmt`, and the wallet payload (stored temporarily in session or passed via request parameter).
   - Loads the first saved job (`jobId0`).
   - Calls `ProcessCcWebSrvc.processWalletPay(jobId0, userCellNum, walletBody, paymentType, JLimoMode.EDIT, "SALE")` with `walletBody.total` set to `Math.round(dueAmt * 100)`.
   - On success, reuses the existing `handlePostSaleMultiTrip` logic to create `JobCharge` records for each job and attach the purchase order.
   - On failure, calls `restoreTabJobs` and sets error messages (same pattern as `runProcessMultiTripSale`).
2. In `processTabJobsCcAfterSave`, before the existing `processMultiTripSale` calls, add a branch:
   ```java
   if (FopType.isAppleOrGooglePay(fop.getFopCode())) {
       return processMultiTripWalletPay(webReq, pa, jv, tjv, fop, htResults, dueAmt, savedJobsDueAmt);
   }
   ```
   This intercepts wallet FOPs and routes them to the new wallet-specific charger.

### Phase 4 — Frontend: Post-Save Wallet Flow for TabJobs

**File:**
- `JLimoCore/JlimoWeb_Core/src/main/resources/META-INF/resources/js/quickReservation/tabJobs.js`

**Changes:**
1. In `tabJobs_saveTabJobs`, intercept the save response when `tabjobsFop` is `AP` or `GP`.
2. If jobs are saved successfully (response contains `tabJobsSaved`), do **not** redirect immediately. Instead:
   - Set `window._qrWalletPostSaveMode = tabjobsFop`.
   - Call `launchWalletFromBasePage(tabjobsFop)` to open the Apple/Google Pay sheet.
3. The existing `BookWithApplePay.js` / `BookWithGooglePay.js` will POST to `applePayAuthorize` / `googlePayAuthorize`. These endpoints currently use `jv.getWebJob()` (the active tab job). For multi-trip, we need the backend to recognize that this is a TabJobs wallet auth and route to the aggregate flow.
   - **Option A (recommended):** Create new ajax types `tabJobsApplePayAuthorize` and `tabJobsGooglePayAuthorize` in `QuickReservation.java`. They read the aggregate due amount from `TabJobsVars`, call `processMultiTripWalletPay`, and return a success/failure JSON. The frontend wallet JS can be pointed to these new endpoints when in TabJobs mode.
   - **Option B:** Modify the existing `applePayAuthorize` / `googlePayAuthorize` to detect `Gen.isUseTabJobs(webReq)` and switch behavior. This is riskier because it mixes single- and multi-trip logic.
4. On wallet auth success, redirect to `tripConfTj`. On failure, show error inline and re-enable the Save button (same as single-job wallet failure handling).

## Critical Files to Modify

| File | Phase | What |
|------|-------|------|
| `JlimoWeb_Core/.../includes/TabJobsCC.jsp` | 1 | Add AP/GP dropdown items, hidden wallet button containers, data attributes for merchant IDs |
| `JlimoWeb_Core/.../js/quickReservation/tabJobs.js` | 1, 4 | `switchTabJobsFop` AP/GP cases; post-save wallet launch intercept |
| `JlimoWeb_Core/.../servlets/QuickReservation.java` | 2, 3 | `saveTabJobs` switch; new `processMultiTripWalletPay`; new ajax cases `tabJobsApplePayAuthorize` / `tabJobsGooglePayAuthorize`; routing in `processTabJobsCcAfterSave` |
| `JlimoDataLibrary/.../cc/ProcessCcWebSrvc.java` | 3 | Reuse `processWalletPay`; no changes needed if `QuickReservation` calls it directly, but verify `processWalletPay` supports `transType="SALE"` (it does) |

## Reusable Utilities

- `BookWithApplePay.js` / `BookWithGooglePay.js` — wallet sheet logic, merchant validation, payload formatting.
- `QRWalletCommon.js` — shared ajax helpers and amount formatting.
- `handlePostSaleMultiTrip` in `QuickReservation.java` — charge-splitting across jobs after a successful sale.
- `ProcessCcWebSrvc.processWalletPay` — single-job wallet gateway call (reused with first job and total amount).

## Verification / Testing

1. **Frontend only:** Load TabJobs reservation page. Verify Apple Pay and Google Pay appear in the FOP dropdown when profile flags are enabled. Verify selecting them hides the CC form and shows the wallet button (or triggers on save).
2. **Backend save:** Set a breakpoint in `saveTabJobs` switch. Verify `fop.getFopCode()` is `AP` or `GP` and not falling into the `CC` default branch.
3. **Multi-trip charge:** Book 2+ trips with Apple Pay. Verify:
   - Jobs are saved to `PENDING_CC`.
   - Wallet sheet opens with the correct total.
   - After auth, `ProcessCcWebSrvc.processWalletPay` is called once with the aggregate amount.
   - `JobCharge` records exist for each job under the same multi-trip order ID.
   - Redirect to `tripConfTj` occurs.
4. **Failure case:** Trigger a declined wallet payment. Verify jobs are restored (status rolled back), error message displays, and user stays on the payment screen.

## Open Questions

1. Should the wallet charge be a `SALE` (immediate capture) or `PREAUTH` (authorize now, capture later)? The single-job flow currently uses `PREAUTH`. For multi-trip, the existing CC flow defaults to `SALE` via `processMultiTripSale`. We should match the CC behavior: use `SALE` for prepay/chargeInstead, and `PREAUTH` for autopay (if within window).
2. Do we need to support wallet auto-pay (authorize 48h before trip) for TabJobs? If yes, the aggregate auto-pay logic in `processMultiTripAutoPay` must also get a wallet branch.
