# Plan: Complete Reorganization of 0Learning+Projects

## Context
The user's `/Users/abhishek/0Learning+Projects/` directory has grown organically. It contains:
- Phase-based syllabuses (SYLLABUS-00 through 04)
- A ROADMAP.md and PROJECT_BLUEPRINTS.md
- Multiple project folders (RAG, AWS, Rust Engine, Web_Projects, etc.)
- Downloaded tutorials (Chinese Tutorials/codefather.cn)
- Cloned third-party repos (FoloUp, vot-selfhost, OpenMAIC, MiroFish)
- Study notes (source-code-learning/OpenJDK)
- Personal notes (BodyHealth+MentalHealth, Apple Notes)
- DSA practice, Exercism, Hyperskill

**Problem:** Nothing links together. Finding the next step requires memory. A beginner gets lost.
**Goal:** One master roadmap. Every markdown links to the next. One click away from anything.

## Target Directory Structure

```
0Learning+Projects/
├── 00-START-HERE/
│   ├── README.md                 ← Master roadmap. ONLY file a beginner opens.
│   ├── CONTINUE.md               ← Paste into Claude to resume any session.
│   └── HOW-TO-USE.md             ← "I am new. What do I do today?"
│
├── 01-Foundations/               ← Phase 0
│   ├── INDEX.md                  ← Phase 0 dashboard
│   ├── DSA/
│   ├── Java-Core/                ← Exercism, Hyperskill, source-code-learning notes
│   ├── OS-Networks/
│   ├── Databases/
│   ├── System-Design/
│   └── Videos/                   ← Curated video playlists per topic
│
├── 02-Java-RAG-Security/         ← Phase 1
│   ├── INDEX.md                  ← Phase 1 dashboard
│   ├── Spring-Boot/
│   ├── Vector-DB/
│   ├── App-Security/
│   ├── Threat-Modeling/
│   └── Blog-Instructions/        ← How to write + publish blog posts
│
├── 03-Python-AI-Agentic/         ← Phase 2
│   ├── INDEX.md                  ← Phase 2 dashboard
│   ├── FastAPI-Agent/
│   ├── Prompt-Injection/
│   ├── Indirect-Injection/
│   └── RAG-Poisoning/
│
├── 04-Systems-Tooling/           ← Phase 3
│   ├── INDEX.md                  ← Phase 3 dashboard
│   ├── Go-Gateway/
│   ├── Rust-Scanner/
│   ├── React-Dashboard/
│   └── C-Binary-Exploitation/
│
├── 05-Business-Monetization/     ← Phase 4
│   ├── INDEX.md                  ← Phase 4 dashboard
│   ├── Personal-Blog/
│   ├── Consulting/
│   └── Conference-CFP/
│
├── 06-Resources/                 ← Cross-cutting, evergreen
│   ├── INDEX.md
│   ├── Books-And-Papers/
│   ├── Video-Libraries/
│   ├── Blog-Writing-Guide/       ← RAG/BLOG-STYLE-NOTES.md, BUILD-YOUR-BLOG.md, etc.
│   ├── Chinese-Tutorials-Western-Map/  ← codefather.cn → US/UK/EU stack translation
│   └── Resume-Interview/
│
├── 07-Archive/                   ← Not active learning material
│   ├── Cloned-Projects/          ← FoloUp, vot-selfhost, OpenMAIC, MiroFish
│   ├── Personal-Notes/           ← BodyHealth+MentalHealth, Apple Notes
│   ├── Scraped-Content/          ← scraping-free-exam-dumps
│   └── Old-Downloads/            ← yt-dlp-download, Kindle Jailbreak
│
└── 08-Projects-Active/           ← Code repositories you are building
    ├── java-rag-evolution/       ← From RAG/ chapters
    ├── rust-viz-engine/          ← From Rust Engine/
    ├── python-ai-agent/
    ├── go-security-gateway/
    └── react-security-dashboard/
```

## Existing Content Mapping

| Current Location | New Location | Notes |
|-----------------|--------------|-------|
| `ROADMAP.md` | `00-START-HERE/README.md` | Expanded with all links |
| `MASTER_INDEX.md` | `00-START-HERE/README.md` | Merged into master |
| `PROJECT_BLUEPRINTS.md` | `00-START-HERE/PROJECT_BLUEPRINTS.md` | Keep, link from README |
| `SYLLABUS-00.md` | `01-Foundations/INDEX.md` + `01-Foundations/SYLLABUS.md` |
| `SYLLABUS-01.md` | `02-Java-RAG-Security/INDEX.md` + `SYLLABUS.md` |
| `SYLLABUS-02.md` | `03-Python-AI-Agentic/INDEX.md` + `SYLLABUS.md` |
| `SYLLABUS-03.md` | `04-Systems-Tooling/INDEX.md` + `SYLLABUS.md` |
| `SYLLABUS-04.md` | `05-Business-Monetization/INDEX.md` + `SYLLABUS.md` |
| `RAG/*.md` (guides) | `06-Resources/Blog-Writing-Guide/` |
| `RAG/chapters/*.md` | `02-Java-RAG-Security/Spring-Boot/` or keep in `RAG/` and link |
| `AWS/*.md` | `01-Foundations/System-Design/` or `01-Foundations/Cloud/` |
| `source-code-learning/study-notes/` | `01-Foundations/Java-Core/OpenJDK-Notes/` |
| `Rust Engine/*.md` | `04-Systems-Tooling/Rust-Scanner/` |
| `RustroverProjects/` | `01-Foundations/Rust-Basics/` or `04-Systems-Tooling/Rust-Scanner/` |
| `Web_Projects/cfny/` | `04-Systems-Tooling/React-Dashboard/reference/` |
| `FoloUp/` | `07-Archive/Cloned-Projects/FoloUp/` |
| `vot-selfhost/` | `07-Archive/Cloned-Projects/vot-selfhost/` |
| `Chinese Tutorials/codefather.cn/` | `06-Resources/Chinese-Tutorials-Western-Map/` |
| `Chinese Tutorials/PersonalProjects/` | Evaluate per project, move to active or archive |
| `BodyHealth+MentalHealth/` | `07-Archive/Personal-Notes/` |
| `scraping-free-exam-dumps/` | `07-Archive/Scraped-Content/` |
| `Exercism/` | `01-Foundations/DSA/Exercism/` |
| `Hyperskill-Bootcamps/` | `01-Foundations/Java-Core/Hyperskill/` |

## The Linking System

Every markdown must have a header block:
```markdown
> **Phase:** X
> **Tech:** Java, Spring Boot, PostgreSQL
> **Prerequisites:** [Phase 0 DSA](../01-Foundations/DSA/INDEX.md)
> **Next Action:** Create Maven project
> **Links:** [Master Roadmap](../00-START-HERE/README.md) | [Phase Index](./INDEX.md) | [Next Step](./next-file.md)
```

Every INDEX.md must have:
- Table of all files in that folder with descriptions
- Exit criteria checklist
- "Next" and "Previous" phase links
- "I am stuck" link to CONTINUE.md

## Phase-by-Phase Execution Plan

### Phase 1: Skeleton + Master Roadmap (5 files max)
1. Create `00-START-HERE/`, `01-Foundations/` through `07-Archive/`, `08-Projects-Active/` (empty)
2. Write `00-START-HERE/README.md` — the ONE file that rules them all
3. Write `00-START-HERE/CONTINUE.md` — session resume instructions
4. Write `00-START-HERE/HOW-TO-USE.md` — "What do I do today?"
5. Move existing top-level .md files into `00-START-HERE/` (ROADMAP, PROJECT_BLUEPRINTS, SYLLABUS files)

**Checkpoint:** User reviews. Approve before Phase 2.

### Phase 2: Phase Indexes (5 files max)
1. Write `01-Foundations/INDEX.md`
2. Write `02-Java-RAG-Security/INDEX.md`
3. Write `03-Python-AI-Agentic/INDEX.md`
4. Write `04-Systems-Tooling/INDEX.md`
5. Write `05-Business-Monetization/INDEX.md`

**Checkpoint:** User reviews.

### Phase 3: Move Existing Content (batch by batch)
1. Move `RAG/*.md` into `06-Resources/Blog-Writing-Guide/`
2. Move `RAG/chapters/` into `02-Java-RAG-Security/Spring-Boot/`
3. Move `AWS/*.md` into `01-Foundations/Cloud/`
4. Move `source-code-learning/study-notes/` into `01-Foundations/Java-Core/`
5. Move `Rust Engine/*.md` into `04-Systems-Tooling/Rust-Scanner/`

**Checkpoint:** User reviews.

### Phase 4: Special Content
1. Create `06-Resources/Chinese-Tutorials-Western-Map/INDEX.md` — map codefather.cn projects to western stacks
2. Create `06-Resources/Video-Libraries/INDEX.md` — curated videos per topic
3. Update all moved markdowns with new cross-links
4. Create `08-Projects-Active/README.md` — active code project registry

### Phase 5: Archive Cleanup
1. Move cloned repos to `07-Archive/Cloned-Projects/`
2. Move personal notes to `07-Archive/Personal-Notes/`
3. Move scraped content to `07-Archive/Scraped-Content/`
4. Verify no broken links in master roadmap

## CONTINUE.md Contents

```markdown
# CONTINUE — Resume Any Session

Paste this ENTIRE block into a new Claude session:

```
I am continuing my learning roadmap reorganization in /Users/abhishek/0Learning+Projects/.

CURRENT STRUCTURE:
- 00-START-HERE/ contains README.md (master roadmap), CONTINUE.md, HOW-TO-USE.md
- 01-Foundations/ through 05-Business-Monetization/ contain phase indexes
- 06-Resources/ contains cross-cutting materials (books, videos, blog guides, chinese tutorial maps)
- 07-Archive/ contains cloned repos, personal notes, scraped content
- 08-Projects-Active/ contains code repositories I am building

MY MISSION:
[User fills in: e.g., "Move RAG chapters to 02-Java-RAG-Security/", "Create Chinese tutorial western map", etc.]

RULES:
- I am a beginner. Use simple language. No jargon without explanation.
- Every markdown must link to the master roadmap and its phase index.
- Do NOT rename or move files without updating all links.
- Work in phases. Complete current phase, verify, wait for my approval.
```
```

## Key Files to Create / Modify

| File | Action |
|------|--------|
| `00-START-HERE/README.md` | NEW — Master roadmap with all links |
| `00-START-HERE/CONTINUE.md` | NEW — Session resume instructions |
| `00-START-HERE/HOW-TO-USE.md` | NEW — Daily usage guide |
| `00-START-HERE/PROJECT_BLUEPRINTS.md` | MOVE from top-level |
| `00-START-HERE/SYLLABUS-00.md` | MOVE + update links |
| `00-START-HERE/SYLLABUS-01.md` | MOVE + update links |
| `00-START-HERE/SYLLABUS-02.md` | MOVE + update links |
| `00-START-HERE/SYLLABUS-03.md` | MOVE + update links |
| `00-START-HERE/SYLLABUS-04.md` | MOVE + update links |
| `01-Foundations/INDEX.md` | NEW |
| `02-Java-RAG-Security/INDEX.md` | NEW |
| `03-Python-AI-Agentic/INDEX.md` | NEW |
| `04-Systems-Tooling/INDEX.md` | NEW |
| `05-Business-Monetization/INDEX.md` | NEW |
| `06-Resources/INDEX.md` | NEW |
| `06-Resources/Chinese-Tutorials-Western-Map/INDEX.md` | NEW |
| `06-Resources/Video-Libraries/INDEX.md` | NEW |
| `06-Resources/Blog-Writing-Guide/INDEX.md` | NEW |
| `07-Archive/INDEX.md` | NEW |
| `08-Projects-Active/README.md` | NEW |

## Verification
After each phase:
1. Run `find 0Learning+Projects -name "*.md" | sort` to verify file list
2. Open `00-START-HERE/README.md` and click every link mentally
3. Check that every INDEX.md has "Previous Phase" and "Next Phase" links

## Open Questions for User
1. Should we PHYSICALLY move files, or keep them in place and only create the index/roadmap system?
2. The `Chinese Tutorials/codefather.cn` folder is very large (100s of files). Should we create a mapping INDEX.md for it without moving it?
3. `source-code-learning/` is a full OpenJDK clone (GBs). Moving it is expensive. Should it stay and just be linked?
