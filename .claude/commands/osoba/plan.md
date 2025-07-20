---
allowed-tools: TodoWrite, TodoRead, Bash, Read, Grep, Glob, LS
description: "Create implementation plan"
---

# Plan

## Context 

- Specification Driven Development: @.claude/osoba/docs/spacification_driven_development.md
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

### 4. Check Design and Task List

- Verify that the Stage 2 output (`.tmp/design.md`) matches the original requirements  
- Verify that the Stage 3 output (`.tmp/tasks.md`) matches the original requirements  
- Ensure that both Stage 2 and Stage 3 outputs are posted as comments in the GitHub Issue  

Use:  
Check issue comment: `GH_PAGER= gh issue view <issue number> --comments`
Comment design: `GH_PAGER= gh issue comment <issue number> --body-file .tmp/design.md`
Comment tasks: `GH_PAGER= gh issue comment <issue number> --body-file .tmp/tasks.md`

Proceed only if all three checks pass.

### 5. Update Issue Label

Run:
`GH_PAGER= gh issue edit <issue number> --remove-label "status:planning" --add-label "status:ready"`

## Important Notes

- Do NOT modify the codebase at this stage
- Each stage output must be detailed and actionable
- Focus on clarity and completeness in documentation
- Consider edge cases and error scenarios during each stage

think hard

