# Task Board: AIO Wealth Hub (Personal Finance & Wealth Intelligence)

## Phase 1: Specifications & Connector Inventory [IN PROGRESS]
1. [x] Define global unified ledger data model (multi-currency USD + INR) → verify: schema validated for loans, investments, cash, insurance
2. [ ] Map authentication and extraction strategy per connector → verify: public API vs REA reverse-engineering path documented
3. [ ] Build interactive architecture explainer & forecasting simulator → verify: single-file HTML renders without console errors
4. [ ] Collect required credentials and statement access from user → verify: all required inputs enumerated

## Phase 2: REA Reverse-Engineering & Native Connectors
1. [ ] Apple Card statement & wallet sync recipe → verify: REA flow captures exported records or Shortcut automation
2. [ ] Google Play recurring subscription inventory parser → verify: extracted subscriptions match active renewal dates
3. [ ] Amex and US Banking connector (Plaid/OFX bridge) → verify: real balances match checking/credit statements
4. [ ] Indian Account Aggregator (AA) & Mutual Fund CAMS/KFintech parser → verify: Indian portfolio totals match INR balances

## Phase 3: Splitwise, Loans & Indian Life Insurance Engine
1. [ ] Splitwise OAuth2 connector for net friend/group balances → verify: unsettled balances match live app
2. [ ] Loan amortization tracker (US + Indian loans) → verify: principal + APR amortization schedule accurate
3. [ ] Indian Insurance Tracker (LIC & term policies) → verify: premium calendar + maturity values calculated

## Phase 4: Wealth Intelligence & Habit Prediction Engine
1. [ ] Subscription creep & recurring leak detector → verify: unused subscriptions flagged
2. [ ] Forward-looking Monte Carlo runway & savings simulator → verify: 12-month prediction reflects spending patterns
3. [ ] Local SQLite/DuckDB encrypted store & personal dashboard → verify: zero secrets leak outside localhost
