---
name: frontend-research
description: Research frontend/React website questions against big-company primary sources (React.dev, MUI, web.dev, Netflix, Meta, Uber, Databricks, Google, Microsoft, Amazon engineering) and capture findings as a Markdown file in the repo. Use when the user wants the WEBSITE frontend (ReactJLimoWeb/cust_web) researched for performance, scalability, theming, or architecture. Scoped to the website only — never passenger_link or other apps.
---

Spin up a **background agent** to do the research, so you keep working while it reads.

## Scope guardrails (binding)

- Scope is the **website frontend only**: `ReactJLimoWeb/cust_web/client/src/projects/website/`.
- Do not propose changes to `passenger_link`, other React projects, JlimoApi, JlimoDataLibrary, or any backend architecture. If a finding would require touching them, record it as "out of scope — note only".
- The goal is a high-performant, maintainable, multi-tenant website that respects the existing conventions: 3-tier tokens (`theme/websiteTokens.ts`), `themeOverrides` runtime CSS vars per company, string-keyed variant registries with `?? default`, one shared component per repeated design, tenant-neutral naming, one API facade with runtime parsing.

## Source hierarchy (cite only these tiers)

1. **Framework owners** — react.dev (performance, Suspense, transitions, code splitting, state ownership), mui.com docs matching the repo's MUI version (cssVariables, theme scoping, sx performance, tree-shaking), vitejs.dev if build-related.
2. **Platform/Google first-party** — web.dev (INP, LCP, rendering patterns), patterns.dev (Addy Osmani / Lydia Hallie), W3C Design Tokens community draft, m3.material.io.
3. **Big-company engineering blogs, first-party posts only** — netflixtechblog.com, eng.uber.com, medium.com/airbnb-engineering, databricks.com/blog engineering, engineering.fb.com / react.dev blog (Meta), learn.microsoft.com + devblogs.microsoft.com, amazon Builders' Library (aws.amazon.com/builders-library), shopify.dev / polaris tokens, atlasIAN design system tokens.
4. **Books via their canonical sites** — dataintensive.net (DDIA), martinfowler.com. No pirate PDFs.

Reject aggregator/SEO blogs. If a claim can only be sourced from a secondary blog, mark it `[secondary]`.

## Agent instructions

1. Read the actual code first — ground every recommendation in what `cust_web` already does, citing `path:line`. Recommendations extend the current conventions, never overhaul them.
2. Fetch the primary source for every external claim; cite the URL. Follow claims back to the owner.
3. Answer with concrete, applicable practices — no generic "use memo" filler. Each finding maps to a specific website surface (wizard, buildup flow, trips, profile, map, theme system, API layer).
4. Cover, as relevant to the question: render performance (code splitting, memoization discipline, server state vs client state), MUI theming at multi-tenant scale (CSS variables, token tiers), bundle/network (prefetching, route-level splitting), state across refresh (server hydration vs client storage), and component organization (feature folders, variant registry, shared components).

## Output

1. Write findings to ONE Markdown file in `brain/documentation/research/`, named `YYYYMMDD_<TOPIC>_RESEARCH.md`, matching existing files there.
2. Every claim cited (`path:line` for code, URL for web). A final "Applicable to this codebase" section maps each finding to the website surface it touches.
3. Add the file to the index in `brain/documentation/research/README.md`.
