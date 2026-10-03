# Default-On Skills Manifest

Canonical list of skills that are **on by default** for every agent session.
Last updated: 2026-10-03.

Source of truth: `brain/.claude/skills/` (canonical), symlinked into
`brain/.agents/skills/`, `brain/.kilocode/skills/`.

## Always-on learning + engineering skills

| Skill | Category | One-line |
|---|---|---|
| `vibe-wise-learn` | learning | Reasoning-first onboarding for new projects / unfamiliar repos |
| `eli5` | learning | Explain anything to any audience |
| `aas-explain-like-socrates` | learning | Socratic explanation |
| `aas-tutorial-engineer` | learning | Turn a concept into a tutorial |
| `aas-technical-tutorials` | learning | Technical tutorial authoring |
| `aas-learn` | learning | Capture learnings into the knowledge base |
| `aas-cc-skill-continuous-learning` | learning | Continuous learning discipline |
| `aas-learning-career-development` | learning | Career-skill growth guidance |
| `aas-javascript-mastery` | learning | Deepen JS/TS mastery |
| `aas-crossframe-teach` | learning | Teach across frameworks |
| `aas-kaizen` | learning | Continuous improvement of process and code shape |
| `teach` | learning | Teach the user a new skill over sessions |
| `ponytail` | engineering | Write the least that works |
| `caveman` | engineering | Talk concisely |
| `improve-codebase-architecture` | engineering | Find structural deepening opportunities |
| `code-review` | engineering | Two-axis review (Standards + Spec) |
| `tdd` | engineering | Red-green-refactor |
| `diagnosing-bugs` | engineering | Disciplined bug diagnosis loop |
| `domain-modeling` | engineering | Build and sharpen the domain model |
| `codebase-design` | engineering | Deep-module design vocabulary |
| `grill-me` | engineering | Relentless interview to sharpen a plan |
| `grill-with-docs` | engineering | Grill + build the domain model / ADRs |
| `research` | engineering | Investigate against high-trust primary sources |
| `prototype` | engineering | Throwaway prototype to sanity-check a model |
| `handoff` | engineering | Compact a conversation into a handoff doc |
| `wizard` | engineering | Generate an interactive bash wizard |

## Turn off for a session

Say `pause learning` or `learning off`. Say `resume learning` to bring it back.

## Exclusions

- No Jlimo / Limosys skills are installed anywhere in the brain.
- The full Agentic Awesome Skills catalog (2,500+ skills) is **not** installed — only the learning-relevant subset above, to avoid bloating context.