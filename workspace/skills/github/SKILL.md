---
name: github
description: "Interact with GitHub using gh CLI and REST API. Use gh issue, gh pr, gh run, gh api for advanced GitHub operations."
tags: [github, api, issues, pr, ci, workflow, tools]
command_tool: exec
command_template: "gh {args}"
---
# GitHub Skill

Interact with GitHub using `gh` CLI (GitHub CLI tool).
No Node.js or npm required - just uses `gh` commands directly.

## 🚀 Quick Usage

Directly use any `gh` command:
```bash
gh issue create --title "Bug" --body "Description"
gh pr list --repo owner/repo
gh run list --repo owner/repo
```

## 📊 Repository Management

### Create Repository
```bash
gh repo create my-repo --private --description "My new repo"
```

### View Repository
```bash
gh repo view owner/repo --json
```

### Clone Repository
```bash
gh repo clone owner/repo /path/to/clone
```

## 🎯 Issues & Pull Requests

### List Issues
```bash
gh issue list --repo owner/repo
gh issue list --repo owner/repo --json number,title
```

### Create Issue
```bash
gh issue create --repo owner/repo --title "Title" --body "Description"
```

### List Pull Requests
```bash
gh pr list --repo owner/repo
gh pr list --repo owner/repo --json
```

### Create Pull Request
```bash
gh pr create --repo owner/repo --title "Fix bug" --body "Description"
```

### View PR Status
```bash
gh pr checks 55 --repo owner/repo
```

## 🔄 CI & Workflows

### List Workflow Runs
```bash
gh run list --repo owner/repo --limit 10
```

### View Run Details
```bash
gh run view <run-id> --repo owner/repo
```

### View Failed Steps Only
```bash
gh run view <run-id> --repo owner/repo --log-failed
```

### List Workflows
```bash
gh workflow list --repo owner/repo
```

## 🔧 Advanced API Queries

Use `gh api` for REST API access:

### Get PR with specific fields
```bash
gh api repos/owner/repo/pulls/55 --jq '.title, .state, .user.login'
```

### List issues with JQ filtering
```bash
gh issue list --repo owner/repo --json number,title --jq '.[] | "\\(.number): \\(.title)"'
```

### Get repository content
```bash
gh api repos/owner/repo/contents/README.md
```

## 🎨 JSON & JQ Examples

All commands support `--json` output. Use `--jq` for filtering:

### List issues with custom format
```bash
gh issue list --repo owner/repo --json number,title --jq '.[] | "\\(.number): \\(.title)"'
```

### Get PR details
```bash
gh pr view 55 --repo owner/repo --json title,state,author
```

## 🔒 Authentication

This skill uses your existing `gh` CLI authentication. Make sure you're logged in:
```bash
gh auth login
gh auth status
```

## 🛠️ Troubleshooting

### Authentication Error
If you see "not logged in", run:
```bash
gh auth login
```

### Repository Not Found
Make sure to specify `--repo owner/repo` when not in a git directory.

## 📝 Notes

- No Node.js dependency required
- Uses your authenticated `gh` CLI
- All commands support `--json` for structured output
- Supports `--jq` for filtering and formatting
- Supports `--repo owner/repo` flag for remote operations

# GitHub Skill

Interact with GitHub using `gh` CLI and REST API for repository management, issues, PRs, CI workflows, and advanced queries.

## 🚀 Features

### Issue Management
Create, list, view, and comment on issues:
```
/gh create issue --repo owner/repo --title "Bug in feature" --body "Description"
/gh list issues --repo owner/repo
/gh view issue --repo owner/repo 123 --json
```

### Pull Request Management
List, view, create, and manage PRs:
```
/gh list pr --repo owner/repo
/gh view pr --repo owner/repo 55 --json
/gh create pr --repo owner/repo --base main --title "Add new feature"
```

### CI & Workflows
Manage GitHub Actions workflows and runs:
```
/gh run list --repo owner/repo --limit 10
/gh run view <run-id> --repo owner/repo
/gh run view <run-id> --repo owner/repo --log-failed
/gh workflow list --repo owner/repo
```

### Advanced API Queries
Use `gh api` for direct GitHub REST API access:
```
/gh api repos/owner/repo/issues --jq '.[] | {number, title, state}'
/gh api repos/owner/repo/pulls/55 --jq '.title, .state, .user.login'
/gh api repos/owner/repo/actions/runs --limit 5
```

### Repository Management
Clone, create, and manage repositories:
```
/gh repo create my-repo --private --description "My new repo"
/gh repo view owner/repo --json
/gh repo clone owner/repo /path/to/clone
```

### Branch & Tag Operations
```
/gh branch list --repo owner/repo
/gh branch create new-feature main --repo owner/repo
/gh tag list --repo owner/repo
/gh tag create v1.0.0 main --repo owner/repo
```

### JSON Output
All commands support `--json` for structured output. Use `--jq` to filter results:
```
/gh issue list --repo owner/repo --json number,title --jq '.[] | "\(.number): \(.title)"'
```

## 💡 Usage Examples

### Check CI Status
```bash
# View recent workflow runs
/gh run list --limit 10

# Check a specific PR's CI status
/gh pr checks 55 --repo owner/repo

# View failed steps in a run
/gh run view <run-id> --log-failed
```

### Advanced Query with JQ
```bash
# Get PR with specific fields
/gh api repos/owner/repo/pulls/55 --jq '.title, .state, .user.login'

# List issues with custom format
/gh issue list --json number,title --jq '.[] | "\(.number): \(.title)"'
```

### Repository Management
```bash
# Create new repository
/gh repo create my-new-repo --private --description "Description here"

# Clone a repository
/gh repo clone owner/repo ~/dev/repo-name

# View repository details
/gh repo view owner/repo --json
```

## 🛠️ Notes

- All commands prefix with `/gh` for clarity
- Uses the `gh` CLI which must be installed and authenticated
- Commands work with any repository (specify `--repo owner/repo` when not in a git repo)
- Supports both structured (JSON) and human-readable output
- Always uses the authenticated user's permissions
