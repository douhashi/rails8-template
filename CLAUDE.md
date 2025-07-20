# Guideline

## Top-Level Rules

- Run independent processes concurrently, not sequentially.  
- Think only in English; respond only in Japanese.  
- Use **Contex7 MCP** to check library usage.  
- Save temp design notes as `.tmp` in Markdown.  
- After **Write/Edit**, always verify with **Read**, even if system says “(no content)”.  
- Be critical, not obedient—but stay respectful.


## Development Style - Specification-Driven Development

### Overview

When receiving development tasks, please follow the 4-stage workflow below. This ensures requirement clarification, structured design, and efficient implementation.

### 4-Stage Workflow

#### Stage 1: Requirements

- Analyze user requests and convert them into clear functional requirements
- Document requirements in `.tmp/requirements.md`
- Use `/osoba:requirements` command for detailed template

#### Stage 2: Design

- Create technical design based on requirements
- Document design in `.tmp/design.md`
- Use `/osoba:design {Issue number}` command for detailed template

#### Stage 3: Task List

- Break down design into implementable units
- Document in `.tmp/tasks.md`
- Use `/osoba:tasks` command for detailed template
- Manage major tasks with TodoWrite tool

#### Stage 4: Implementation

- Implement according to task list
- Use `/osoba:implement {Issue number}` command for detailed workflow
- For each task:
  - Update task to in_progress using TodoWrite
  - Execute implementation and testing
  - Run lint and typecheck
  - Update task to completed using TodoWrite

### Workflow Commands

- `/osoba:requirements` - Execute Stage 1: Requirements only
- `/osoba:design` - Execute Stage 2: Design only (requires requirements)
- `/osoba:tasks` - Execute Stage 3: Task breakdown only (requires design)
- `/osoba:implement` - Execute Stage 4: Implement (requires task list)
- `/osoba:plan` - Execute Stage 1 and 2: (requires requirements)
- `/osoba:spec` - Start the complete specification-driven development workflow
