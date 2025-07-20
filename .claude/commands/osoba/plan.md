---
allowed-tools: TodoWrite, TodoRead, Bash, Read, Grep, Glob, LS
description: "Create implementation plan"
---

# Plan

## Context 

- GitHub Issue number: $ARGUMENTS

Based on the issue specified by the argument, execute Stage 2 (Design) and Stage 3 (Task List) of the Specification-Driven Development workflow.

## Workflow

### 1. Check Issue

Run `GH_PAGER= gh issue view <issue number>` to review the issue and understand its background.

**Note**: Do NOT use `--comments` because issue content may become unreadable.

### 2. Stage 2: Design

Execute the `/osoba:design` command to create a technical design document based on the requirements.

### 3. Stage 3: Task List

Execute the `/osoba:tasks` command to break down the design into implementable tasks.

### 4. Update Issue Label

Run:
`GH_PAGER= gh issue edit <issue number> --remove-label "status:planning" --add-label "status:ready"`

## Important Notes

- Do NOT modify the codebase at this stage
- Each stage output must be detailed and actionable
- Focus on clarity and completeness in documentation
- Consider edge cases and error scenarios during each stage

think hard

