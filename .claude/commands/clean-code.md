---
description: Apply Uncle Bob's Clean Code principles to make code readable, modular, testable, and maintainable.
argument-hint: "[file, directory, or PR]"
allowed-tools:
  - Read
  - Agent
  - Glob
  - Grep
  - Bash(git diff:*, git log:*, git show:*)
---

# Clean Code (Uncle Bob)

Apply the core principles of "Clean Code" by Robert C. Martin to transform working code into clean code.

## Core Rules

1. **Meaningful names**: Intent-revealing (`elapsedTimeInDays` not `d`). Class names are nouns (`Customer`), method names are verbs (`postPayment`). No `data`, `item`, `temp`, `info`, `obj`.
2. **Small functions**: Target ≤20 lines. Do one thing at one level of abstraction.
3. **Arguments**: 0-2 ideal, max 4. At 5, introduce a parameter object. Never use boolean flag arguments.
4. **Comments**: Don't comment bad code—rewrite it. Comments explain *why*, not *what*. Delete commented-out code.
5. **Law of Demeter**: Avoid chained traversal (`a.getB().getC().doSomething()`).
6. **Error handling**: Exceptions over return codes. Never return null; never pass null.
7. **TDD**: Tests are Fast, Independent, Repeatable, Self-Validating, Timely (F.I.R.S.T.).
