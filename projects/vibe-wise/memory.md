# Memory

## Now
- vibe-wise is a Claude Code plugin (v0.1.43) by Noah Kim, living at `/Users/abhishek/abhishek-projects/vibe-wise`.
- Remote: https://github.com/nykooi1/vibe-wise.git (public). Branch `main`, last commit `1135f4a`.

## Project
- **Name:** VibeWise
- **What:** Learning-first Claude Code plugin. Puts the learner in control: Claude asks for your approach, explores tradeoffs, explains concepts, and only writes code after you approve the design (Build → Design → Implementation checkpoints).
- **Mechanics:** Python 3 hook (`hooks/session_start.py`) restores learning context on SessionStart; `skills/reset/reset.py` backs up and resets `.vibe-wise/` learning notes on confirmation. No backend, analytics, accounts, or extra deps.
- **State dir:** `.vibe-wise/` in the target project (gitignore recommended). Legacy `.sensible-vibes/` still restored for rename coverage.

## Working Style
- Edit mode: agent writes code upon request.
- Phased execution: max 5 files per phase.
- Code quality: clean code, proper typing, test verification.

## Recent Decisions
- Added vibe-wise to central brain project tracking alongside ecommerce-website.

## Open Threads
- None active. Repo is in a stable released state (dev docs cut from README in latest commit).