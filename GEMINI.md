# GEMINI.md

> Canonical Gemini / Antigravity Agent Configuration for Ecommerce Website.
> Master project governance lives in `brain/AGENTS.md`.

## Default modes

On for every agent. Canonical text is `brain/AGENTS.md`. Off with `stop ponytail`, `stop grill-me`, or `stop caveman`.

- **Ponytail.** YAGNI ladder before new code: skip it, else stdlib, else platform, else one line, else the minimum. No guard for a state the caller already proved. When editing a method, delete dead branches in that method only. No new abstraction, dependency, or file unless asked. Still validate trust boundaries and anything that prevents data loss.
- **Grill-me.** Before a design or code change, ask the current decision frontier in one round. Number each question and give a recommended answer, then wait. Look up facts. Do not grill lookups. Do not write the change until the user agrees.
- **Caveman full.** Drop articles, filler, hedging, and pleasantries. Fragments OK. Technical terms, code, numbers, and errors stay exact. No invented abbreviations. No tool-call narration. Drop caveman for security warnings, irreversible actions, and unclear compression. Code, commits, and PR text stay normal.
- **Clean-code.** Uncle Bob Clean Code principles on every code edit or creation: intention-revealing names, functions ≤20 lines doing one thing at one abstraction level, ≤3 arguments (max 4, object at 5), zero bad comments (code explains itself, delete commented-out code and step-markers), no side effects, Law of Demeter, exceptions over return codes, never return/pass null, test-driven with FIRST principles.
- **Clean-code-guard.** Guard-pass on every generated or changed code block before delivery: SOLID (SRP, OCP, LSP, ISP, DIP), DRY/KISS/YAGNI (complexity ≤10, nesting ≤5, no speculative flags/abstractions), and LLM failure mode checks (no broad exception swallowing, no fake fixture returns, no hallucinated packages). Re-run self-check before presenting edits.
- **Karpathy-gate.** On for every agent. The Andrej Karpathy way of coding: 4 checks on every code change + execution loop always on. Source text: `brain/.opencode/skills/karpathy-guidelines/SKILL.md`, pinned to `multica-ai/andrej-karpathy-skills` commit `2c606141`. (1) *Think before coding* — Grill-me; surface confusion/tradeoffs first. (2) *Simplicity first* — Ponytail; minimum code, zero speculative abstractions or configurable flags. (3) *Surgical changes* — walk diff, every changed line traces directly to request, clean up only your own orphans. (4) *Goal-driven execution loop* — before multi-step work, always structure plan as `1. [step] → verify: [check]`, and loop/iterate until check passes. A step whose check cannot run is marked `verify: none — <reason>` and reported unverified. Never claim verified on a check that did not run. Off with `stop karpathy`.
- **Make-it-click.** On for every agent. Format every explanation, summary, complex architectural concept, and model output using the Make-It-Click ladder: Step 1 (80% Simplified Technical English / clear active prose), Step 2 (Diagrams), Step 3 (Interactive single-file HTML explainers), Step 4 (Oversight mode: What changed, Why, Risk, Human check list). Idea credit Andrej Karpathy. Source text: `brain/.opencode/skills/make-it-click/SKILL.md`, pinned to `ajithraghavan/make-it-click` commit `634cc638`. Off with `stop make-it-click`.
- **Taste & Frontend Anti-Slop.** On for every agent. Enforce high-end visual design and anti-slop rules on every web/mobile UI task (`design-taste-frontend`, `impeccable`, `frontend-design`, `anti-ui-slop`, `brandkit`). Zero generic templates, zero cards-inside-cards, intentional typography (Geist / tabular nums), concentric double-bezel borders, and responsive micro-motion. Off with `stop taste`.
- **Reverse-Engineer-First (REA & Network Intelligence).** On for every agent when integrating or modeling existing systems. Never guess backend payloads, auth flows, or data contracts. Use REA tools (`reverse-engineer-anything`, REA MCP server) to inspect network captures, decompile client bundles, and extract ground-truth schemas before authoring code. Off with `stop rea`.


## Mandatory Read Order

Before making decisions or changing files:

1. Read `CLAUDE.md` (project directives, Claudify OS architecture, retrieval map).
2. Read `.claude/memory.md` (active session context and working style).
3. Read `Task Board.md` (active sprint and queued tasks).
4. Read `.claude/knowledge-base.md` (system-wide learned rules and constraints).

---

## Core Invariants

1. **Phased Execution:** Break complex tasks into explicit phases of max 5 files. Verify each phase before continuing.
2. **Forced Verification:** Run type checks and linters before marking tasks complete.
3. **No Secrets in Project Context:** Never commit API keys, tokens, or credentials to source code or git. Use `.env` files.
4. **Follow Memory Rituals:** Update `.claude/memory.md` and `Task Board.md` to keep context fresh across sessions.

---

## Gemini Multi-Agent Orchestration

The workspace provides dedicated subagent roles under `.gemini/agents/`:

- **`leader`**: Technical Architect & Orchestrator. Owns high-level planning, structural design, task decomposition, and delegation.
- **`developer`**: Senior Systems Engineer. Implements assigned tasks with zero mocks, production quality, and test verification.
- **`researcher`**: Internet Researcher. Performs web searches and references primary documentation to return concise, source-cited facts.
- **Specialist Subagents**: Full specialist suite available in `.gemini/agents/` (including `auditor`, `unsticker`, `error-whisperer`, `rubber-duck`, `debt-collector`, `archaeologist`, `onboarding-sherpa`, `pr-ghostwriter`, and SEO/Content specialists).

---

## Customizations & Discovery

- **Skills**: Discovered automatically from `.claude/skills/` (and `.agents/skills/`, `.gemini/skills/`).
- **Rules**: `CLAUDE.md` and `GEMINI.md` load hierarchically from the workspace root.
- **MCP Servers**: Configured in `.mcp.json` (and `.gemini/mcp_config.json`).
