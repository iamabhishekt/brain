# Task Board: AIO Wealth Hub (Personal Finance & Wealth Intelligence)

## Phase 1: Specifications & Connector Inventory [COMPLETED]
1. [x] Define global unified ledger data model (multi-currency USD + INR) → verify: `models.rs` & `types.ts` validate loans, investments, cash, insurance
2. [x] Map authentication and extraction strategy per connector → verify: `documentation/connectors-inventory.md` maps $0-cost extraction pathways
3. [x] Build interactive architecture explainer & forecasting simulator → verify: `documentation/20261014_AIO_WEALTH_HUB_EXPLAINER.html` renders offline
4. [x] Collect required connectors and statement formats → verify: enumerated in README and frontend dropzone

## Phase 2: High-Performance Rust Backend & Zero-Cost Connectors [COMPLETED]
1. [x] Implement local SQLite multi-currency persistence engine → verify: `src/ledger.rs` upserts accounts & subscriptions
2. [x] Implement Apple Card CSV & Amex statement parsers → verify: `cargo test` passes `tests::test_csv_parsers`
3. [x] Implement free Splitwise client & Indian Mutual Fund e-CAS / LIC models → verify: `cargo test` passes `tests::test_ledger_and_forecaster_flow`
4. [x] Implement Axum HTTP REST server (`/api/accounts`, `/api/forecast`, `/api/parse/*`) → verify: `cargo check` clean with 0 warnings

## Phase 3: Cross-Platform Common Frontend (Android, iOS, Web) [COMPLETED]
1. [x] Scaffold Vite + React + TypeScript + Tailwind CSS UI → verify: `npm run build` compiles clean in 758ms
2. [x] Build Native Bridge (`nativeBridge.ts`) with Biometrics, Secure Enclave, and Local Push Notifications → verify: Face ID / Touch ID / Fingerprint & zero-server push support
3. [x] Build Consolidated Net Worth Hero (USD/INR toggle, FX rate, Assets/Liabilities/Runway) → verify: interactive responsive display
4. [x] Build Accounts, Cards & Debt Payoff Grid → verify: filter by US/India, custom APR & minimum dues
5. [x] Build Subscription Creep Radar (Google Play, Apple Subscriptions) → verify: annual drag computed & 1-tap cancellation flagging
6. [x] Build 12-Month Spending & Net Worth Forecaster → verify: interactive slider adjusts Monte Carlo trajectory
7. [x] Configure Tauri v2 (`src-tauri/tauri.conf.json`, `Cargo.toml`, `main.rs`) for native iOS (.ipa) & Android (.apk) packaging

## Phase 4: Automated Twice-Daily Ingestion Pipeline ($0.00 Cost) [COMPLETED]
1. [x] Implement Rust `SyncDaemon` hot-folder watcher & 12h scheduled cycle → verify: `aio-wealth-backend` spawns background loop on startup
2. [x] Implement zero-dependency IMAP statement fetcher (`scripts/fetch_statements_imap.py`) → verify: downloads attachments from Chase, PNC, Amex, Toyota, HDFC, Progressive, PSEG, Telecoms, CAMS, Netflix
3. [x] Configure silent macOS `launchd` background agent (`scripts/setup_daily_cron.sh`) → verify: scheduled for 08:00 AM & 08:00 PM runs
4. [x] Build `AutomatedSyncCard` UI with live status indicator and 1-click sync trigger → verify: `npm run build` passes in 820ms
5. [x] Document 1-time Apple Shortcuts real-time tap sync & CAMS e-CAS schedule → verify: `documentation/automated-daily-sync-guide.md` created
6. [x] Implement In-App Multi-Gmail & IMAP Vault (Zero Shell Exports) → verify: store multiple inboxes directly in SQLite & Keychain, test connections live from UI (`EmailAccountsManager.tsx`)

## Phase 5: Paychex Live Payroll & Multi-SIM WhatsApp OTP Relay [COMPLETED]
1. [x] Extract and ingest 93 weekly Paychex payroll records (Gross, Deductions, Taxes, Net Direct Deposit) → verify: `+$5,243.42 USD/month` cashflow in SQLite
2. [x] Pair WhatsApp CLI (`wacli 0.21.0`) with `18622151422@s.whatsapp.net` → verify: bidirectional 2FA relay across +1-862, +1-917, and +91-9820
3. [x] Build interactive WhatsApp Wealth Bot (`scripts/whatsapp_wealth_bot.py`) → verify: handles `status`, `accounts`, `subs`, `otp` commands from phone

## Phase 6: SimpleFIN Bridge Live Institution Aggregation [COMPLETED]
1. [x] Exchange single-use Base64 setup token with SimpleFIN Bridge → verify: permanent Access URL stored in `.env`
2. [x] Ingest 15 live financial accounts (Chase, Citi, PNC, Amex, Toyota, Robinhood, Paychex 401k) → verify: `scripts/sync_simplefin.py` populates SQLite
3. [x] Extract and ingest granular Robinhood stock holdings (SPY, JEPI, VIOO, IVV, ITOT, VTI) → verify: `holdings` table populated with shares and market valuations

## Phase 7: Splitwise Full Friends Reconciliation [COMPLETED]
1. [x] Fix Splitwise API connector from `get_current_user` to `get_friends` → verify: sums all 48 friend ledgers correctly
2. [x] Ingest net balance `+$512.08 USD` ($675.57 owed to user, $163.49 owed by user) → verify: updated in SQLite `accounts` table

## Phase 8: Wallos Architecture & Recurring Bills Engine [COMPLETED]
1. [x] Implement Wallos SQLite schema and engine (`scripts/wallos_tracker.py`) → verify: generates `wallos.db` and mirrors to `aio_wealth.sqlite`
2. [x] Synchronize 7 verified recurring obligations (Toyota Loan, HDFC EMI, Costco, Netflix, Google Play, Mobile lines) → verify: hydrated into `SubscriptionRadar.tsx`
3. [x] Vendor full open-source `ellite/wallos` repo into `wallos/` → verify: standalone Docker Compose configuration ready on port 8282

## Phase 9: TypeSafe Jev LLM Bounded Chart of Accounts Classifier [COMPLETED]
1. [x] Integrate TypeSafe.ai System One API with `jev-latest` model → verify: authenticated via `apikey_2227...`
2. [x] Build automated classification script (`scripts/classify_jev.py`) → verify: 100 transactions categorized with 95-100% confidence metrics
3. [x] Wire classification confidence scores into SQLite transaction metadata → verify: visible in `transactions` table

## Phase 10: Complete Mock Elimination & Master Runner [COMPLETED]
1. [x] Purge all hardcoded mock accounts and subscriptions from React state (`App.tsx`) → verify: UI renders purely from live backend
2. [x] Remove demo mode fallbacks from `SplitwisePanel.tsx` → verify: displays live `$512.08` balance
3. [x] Deduplicate SQLite accounts table → verify: deleted placeholder IDs (`us-toyota-loan`, `us-citi-diamond-6617`, etc.)
4. [x] Create master executable build & run script (`run_all.sh`) → verify: single command builds backend, syncs feeds, runs Jev, starts UI

## Phase 11: OpenAccountant Skills & Telecom/Policy Ingestion [COMPLETED]
1. [x] Install 44 OpenAccountant skills from `https://github.com/openaccountant/skills` to `~/.agents/skills/openaccountant`, `aio-wealth-hub/.claude/skills`, and `brain/.claude/skills` → verify: skills installed and indexed
2. [x] Implement OpenAccountant Debt Payoff & Emergency Runway engine (`scripts/open_accountant.py`) → verify: calculates avalanche/snowball payoff and 3.5mo emergency runway from live SQLite ledger
3. [x] Define and verify zero-cost, legal ingestion pathways for T-Mobile, Verizon Fios, Netflix, Jio, Airtel, and Indian Government Policies (DigiLocker / Setu BBPS / IMAP e-statements) → verify: fully documented without brittle scraping or paid aggregators

## Phase 12: In-App Financial Independence (FIRE) Engine & Precision Formatting [COMPLETED]
1. [x] Fix double negative currency formatting bug (`-$-43.64` -> `-$43.64`) in `TransactionsTable.tsx` → verify: Math.abs applied to currency conversions
2. [x] Implement dynamic OpenAccountant REST endpoint (`GET /api/openaccountant/report`) in Axum backend → verify: returns live FIRE targets, savings rates, and runway in <50ms
3. [x] Build comprehensive `FinancialIndependencePanel.tsx` UI with Lean/Standard/Fat FIRE targets, Avalanche vs Snowball debt action plan, and 3.5mo emergency runway → verify: integrated into Overview and dedicated FIRE tab
4. [x] Verify multi-currency toggle ($ / ₹) across all FI indicators and compound growth projection simulator → verify: `npm run build` passes in 839ms


