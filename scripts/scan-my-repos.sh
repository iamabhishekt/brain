#!/usr/bin/env bash
# ==============================================================================
# scan-my-repos.sh — Auto-discover & Register All GitHub Repositories
# ==============================================================================
# Queries GitHub via gh CLI for @iamabhishekt repositories and registers any
# unindexed projects into ~/brain/projects/
# ==============================================================================

set -euo pipefail

BRAIN_DIR="$HOME/brain"
GITHUB_USER="iamabhishekt"

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: gh CLI is not installed or not in PATH."
  exit 1
fi

echo "========================================================"
echo " Scanning GitHub repositories for @$GITHUB_USER"
echo " Brain directory: $BRAIN_DIR"
echo "========================================================"

REPOS_JSON=$(gh repo list "$GITHUB_USER" --limit 100 --json name,description,url,isPrivate,updatedAt 2>/dev/null || echo "[]")

NEW_COUNT=0
TOTAL_COUNT=0

REPOS_JSON="$REPOS_JSON" BRAIN_DIR="$BRAIN_DIR" node -e '
  const fs = require("fs");
  const path = require("path");

  const brainDir = process.env.BRAIN_DIR || process.env.HOME + "/brain";
  const projectsDir = path.join(brainDir, "projects");
  const data = JSON.parse(process.env.REPOS_JSON || "[]");

  if (!fs.existsSync(projectsDir)) {
    fs.mkdirSync(projectsDir, { recursive: true });
  }

  let added = 0;
  for (const repo of data) {
    if (repo.name === "brain") continue;
    const projectFolder = path.join(projectsDir, repo.name);
    const projectMd = path.join(projectFolder, "PROJECT.md");

    if (!fs.existsSync(projectFolder)) {
      fs.mkdirSync(projectFolder, { recursive: true });
    }

    if (!fs.existsSync(projectMd)) {
      const content = `# Project: ${repo.name}\n\n` +
        `- **Remote URL:** ${repo.url}\n` +
        `- **Visibility:** ${repo.isPrivate ? "Private" : "Public"}\n` +
        `- **Description:** ${repo.description || "No description provided"}\n` +
        `- **Last Updated on GitHub:** ${repo.updatedAt}\n` +
        `- **Status:** Discovered from GitHub\n\n` +
        `## Overview\nAuto-discovered by scan-my-repos.\n`;

      fs.writeFileSync(projectMd, content, "utf8");

      const taskBoardMd = path.join(projectFolder, "task-board.md");
      if (!fs.existsSync(taskBoardMd)) {
        fs.writeFileSync(taskBoardMd, `# Task Board: ${repo.name}\n\n## Today\n- [ ] Initial review\n\n## In Progress\n\n## Done\n- [x] Auto-discovered by Universal Brain\n`, "utf8");
      }

      const memoryMd = path.join(projectFolder, "memory.md");
      if (!fs.existsSync(memoryMd)) {
        fs.writeFileSync(memoryMd, `# Memory: ${repo.name}\n\n## Project\n- **Name:** ${repo.name}\n- **URL:** ${repo.url}\n`, "utf8");
      }

      added++;
      console.log(`  + Registered: ${repo.name} (${repo.url})`);
    }
  }

  console.log(`\nScan complete: ${data.length} repos inspected, ${added} newly registered.`);
'

# Commit and push updates to ~/brain
if [ -n "$(git -C "$BRAIN_DIR" status --porcelain projects/)" ]; then
  git -C "$BRAIN_DIR" add projects/
  git -C "$BRAIN_DIR" commit -m "sync(projects): update repository registry from GitHub scan [$(date +"%Y-%m-%d")]"
  git -C "$BRAIN_DIR" push origin main
  echo "✓ Brain registry synced to GitHub."
fi

echo "========================================================"
