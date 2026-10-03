# Workspace Brain

`brain/` is the sole local owner for agent rules, tool configuration, working state,
architecture, documentation, research, chats, transcripts, scripts, and generated
assets for this workspace.

**This brain is multi-project.** It tracks every project you work on — not just one.
Project records live in `brain/projects/<project-name>/` and are surfaced in the
master task index at `brain/projects/TASK-INDEX.md`.

## What's tracked here

| Area | Where |
|---|---|
| **All projects** (100+) | `brain/projects/` — per-project `PROJECT.md`, `task-board.md`, `memory.md`, `scratchpad.md` |
| **Master task index** | `brain/projects/TASK-INDEX.md` — one view across every project |
| **Skills** (151) | `brain/.claude/skills/` — canonical; symlinked into `.agents`, `.kilocode`, etc. |
| **Agents, commands, hooks** | `brain/.claude/`, `brain/.cursor/`, `brain/.trae/`, `brain/.gemini/`, `brain/.codex/`, `brain/.opencode/`, `brain/.kilocode/`, `brain/.dsh/`, `brain/.codebuddy/`, `brain/.qwen/` |
| **Universal rules** | `brain/AGENTS.md`, `brain/CLAUDE.md` |
| **Working state** | `brain/state/` (task board, daily notes, scratchpad) |
| **Automation scripts** | `brain/scripts/` — repo scan, git-push hook, project attach, brain sync, master index |

## Workspace root

`/Users/abhishek` — agent sessions start here so universal context loads before
entering any subdirectory. Product source lives in `abhishek-projects/`, `brain/projects/`,
or wherever you keep it. `brain/` owns the cross-agent OS and state.

## Multi-Machine Sync & New PC Setup

To set up and provision symlinks on a new machine:

```bash
git clone https://github.com/iamabhishekt/brain.git ~/brain
cd ~/brain && bash scripts/setup-new-pc.sh
```

## Discovery Shims

| Root path | Brain owner |
|---|---|
| `AGENTS.md` | `brain/AGENTS.md` |
| `CLAUDE.md` | `brain/CLAUDE.md` |
| `GEMINI.md` | `brain/GEMINI.md` |
| `.claude` | `brain/.claude` |
| `.cursor` | `brain/.cursor` |
| `.trae` | `brain/.trae` |
| `.kilocode` | `brain/.kilocode` |
| `.dsh` | `brain/.dsh` |
| `.agents` | `brain/.agents` |
| `.codebuddy` | `brain/.codebuddy` |
| `.gemini` | `brain/.gemini` |
| `.codex` | `brain/.codex` |
| `.opencode` | `brain/.opencode` |
| `.qwen` | `brain/.qwen` |
| `.mcp.json` | `brain/.mcp.json` |
| `documentation` | `brain/documentation` |
| `skills-lock.json` | `brain/tool-config/skills-lock.json` |
| `Daily Notes` | `brain/state/daily-notes` |
| `Task Board.md` | `brain/state/task-board.md` |
| `Scratchpad.md` | `brain/state/scratchpad.md` |

## Content Ownership

| Content | Destination |
|---|---|
| Universal rules and current state | `brain/` |
| Architecture | `brain/architecture/` |
| Curated docs and research | `brain/documentation/` |
| Local task and daily state | `brain/state/` |
| Workspace utilities & scripts | `brain/scripts/` |
| Tool-specific metadata | `brain/tool-config/` |
| Runtimes | `brain/.claude/`, `brain/.gemini/`, `brain/.cursor/`, `brain/.trae/`, etc. |

## Default-On Skills

A deliberately **small** set of always-on skills — skills load at session start, so
each one costs context on every message. Everything else is installed and **opt-in**:
say "load X" to bring it in for a session.

| Skill | What it does |
|---|---|
| `vibe-wise-learn` | Reasoning-first onboarding for new projects / unfamiliar repos |
| `eli5` | Explain anything to any audience |
| `aas-explain-like-socrates` | Socratic explanation instead of a fact dump |
| `aas-cc-skill-continuous-learning` | Capture learnings into the knowledge base |
| `karpathy-understanding-first` | Outsource thinking, never understanding |
| `karpathy-minimalism` | 200 lines of pure code beats 50 npm packages |
| `karpathy-llm-wiki` | Let the LLM maintain your KB; you explore |
| `ponytail` | Write the least that works |
| `caveman` | Talk concisely |

Full manifest (with the opt-in list): `brain/tool-config/default-skills.md`.

To turn learning off for a session: say "pause learning" or "learning off".
To resume: say "resume learning".