---
allowed-tools: TodoRead, TodoWrite, Bash, Read, Write, Edit, MultiEdit, Grep, Glob, LS
description: "Implementation work using TDD"
---

# Implementation

As a developer, your task is to implement the issue specified by the argument using Test-Driven Development (TDD).

## Top-Level Rules

- Follow a test-first approach
- Adhere to existing coding standards
- Ensure all tests pass before proceeding
- Consider security in all implementations

## Workflow

1. **Review the Issue Requirements**
   - Run `GH_PAGER= gh issue view <issue number>` to view the issue
   - Understand the required functionality

2. **Check Design and Task List**
   - Run `GH_PAGER= gh issue view <issue number> --comments` to view comments
   - Check for design documents and task breakdown

3. **Update ToDo List**
   - Use TodoWrite to expand the task list into actionable items

4. **TDD-Based Implementation**
   - For each task, repeat the following TDD cycle:
     - Write a test first
     - Confirm that the test fails
     - Implement the minimum code required to pass the test
     - Confirm the test passes
     - Commit the change
     - Refactor the code
     - Confirm tests still pass
     - Commit / push changes
   - **Important: Do NOT push if the tests are failing**
   - **Important: If the test still fails after 5 cycles, report the situation and wait for further instructions**

5. **Run Tests**
   - Run unit tests for the implemented part
   - Run full system tests

6. **Create Pull Request**
   - Create a pull request only after all tests pass
   - **Important: Do NOT create a PR unless all tests pass**
   - **Important: Try to fix any failing tests before proceeding**
   - **Important: If tests still fail after 5 cycles, report and await instructions**
   - **Important: Never skip or ignore failing tests, even temporarily**

7. **Completion Report**
   - First, create `.tmp/completion_report.md` using the template below.
   - Then, post the contents of `.tmp/completion_report.md` to the issue as a comment using:
     - `GH_PAGER= gh issue comment <issue number> --body-file .tmp/completion_report.md`
   - Update labels:
     - `GH_PAGER= gh issue edit <issue number> --remove-label "status:implementing" --add-label "status:review-requested"`

   #### ✅ `.tmp/completion_report.md` Template (Japanese)

   ```markdown
   ## 実装完了

   以下のIssueについて、TDDに基づき実装を完了しました。

   - Issue: #<ISSUE番号>
   - 対応内容:
     - [対応した主な機能や修正点を簡潔に列挙]
   - 実装方式: テスト駆動開発（TDD）に準拠
   - テスト状況:
     - 単体テスト: ✅ パス
     - 結合テスト: ✅ パス
     - フルテスト: ✅ パス
   - 関連PR: #<PR番号>

   ご確認のほどよろしくお願いいたします。
   ```
