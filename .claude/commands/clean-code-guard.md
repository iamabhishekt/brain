---
description: Guard-pass on generated or modified code with Clean Code, SOLID, DRY/KISS/YAGNI, and LLM-failure prevention.
argument-hint: "[file, diff, or PR]"
allowed-tools:
  - Read
  - Agent
  - Glob
  - Grep
  - Bash(git diff:*, git log:*, git show:*)
---

# Clean Code Guard

Review generated or changed code against Clean Code, SOLID, DRY/KISS/YAGNI, and LLM failure modes before delivery.

## Guard Imperatives

1. **Functions ≤ 20 lines**, single responsibility, single level of abstraction.
2. **Parameters ≤ 4**, zero boolean flag parameters.
3. **No comments paraphrasing code**, delete commented-out code.
4. **SOLID**:
   - SRP: One actor / stakeholder per module.
   - OCP: Extend via polymorphism / registry, not type-tag branch edits.
   - LSP: Never refuse parent contract or weaken postconditions.
   - DIP: Abstractions live with the client package.
5. **DRY/KISS/YAGNI**:
   - Complexity ≤ 10, nesting ≤ 5.
   - Sandi Metz re-inline rule (wrong abstraction is worse than duplication).
   - Zero speculative flags, interfaces, or dead config vars.
6. **LLM Failure Modes**:
   - Zero swallowed exceptions in broad catch blocks.
   - Zero hardcoded fixture values to pretend tests pass.
   - Zero hallucinated packages or unauthorized dependencies.
