---
allowed-tools: Bash, Read, Write, Edit, MultiEdit, Grep, Glob, LS
description: "Review and merge a Pull Request"
---

# Review Plan

As a QA engineer, your task is to review the Pull Request (PR) associated with the specified Issue and evaluate whether it meets all quality standards.

## Context

- Target Issue number: $ARGUMENTS


## Workflow

### 1. Check the Issue

- Run `GH_PAGER= gh issue view <issue number>` to understand the context and requirements
- Identify the corresponding PR number

- Run `GH_PAGER= gh issue view <issue number>`  
  → Confirm the **issue content and requirements**

- Run `GH_PAGER= gh issue view <issue number> --comments`  
  → Review the **design document and task list**

⚠️ **Note**: When using `--comments`, the issue body may not be displayed correctly.  
Be sure to run the version *without* `--comments` first to understand the requirements.

### 2. Check the PR

- Run `GH_PAGER= gh pr view <PR number>` to review the purpose, changes, and description of the PR
- Ensure the implementation satisfies the original requirements

### 3. Review Code Changes

- Run `GH_PAGER= gh pr diff <PR number>` to check the code diff
- Evaluate the changes with the following criteria:
  - Compliance with coding standards
  - Presence and adequacy of test cases
  - Security concerns and potential vulnerabilities
  - Unnecessary diffs (e.g., debug code, commented-out lines)

### 4. Check CI Results

- Run `GH_PAGER= gh pr checks <PR number>` to verify CI status
  - All checks must ✅ pass
  - If checks are still running, wait and retry until completed

### 5. Post Review Result

- Post the review result using:
  `GH_PAGER= gh pr comment <PR number> --body "$(cat .tmp/review_result.md)"`
- Use the following template for `.tmp/review_result.md`:

```markdown
## Review Result

- Issue: #<issue number>
- PR: #<PR number>

### ✅ Verdict
- [ ] Approved (LGTM)
- [ ] Requires changes

### 👍 Positive Notes
- [List of strengths in the implementation]

### 🛠 Suggestions for Improvement
- [List of specific recommendations]

### 🔍 Additional Notes
- [Optional remarks if any]
```

## Basic Rules

- Ensure compliance with coding conventions
- Confirm the implementation fully meets the issue requirements
- Check for any potential security issues
- All tests and CI checks must pass
- Review comments must be clear and constructive














---
allowed-tools: Bash, Read, Write, Edit, MultiEdit, Grep, Glob, LS
description: "PRのレビューとマージ作業"
---

# レビュー

品質管理エンジニアとして引数で指定されたPRをレビューし、レビュー結果をIssueにコメントする

## ワークフロー

1. **Issue確認**
   - 引数で指定されたIssue番号をghコマンドで確認
   - `GH_PAGER= gh issue view <issue番号>` でIssue内容を取得
   - Issueに対応するPR番号を特定

1. **PR確認**
   - PR番号をghコマンドで確認
   - `GH_PAGER= gh pr view <PR番号>` でPR内容を取得
   - 変更内容と実装目的を把握

2. **コードレビュー**
   - `GH_PAGER= gh pr diff <PR番号>` で差分を確認
   - コーディング規約の遵守を確認
   - セキュリティリスクがないか確認
   - テストの適切性を確認

3. **CI確認**
   - `GH_PAGER= gh pr checks <PR番号>` でCI結果を確認
   - 全てのチェックがパスしていることを確認
   - CIが実行中の場合は、少し待ってから再度確認すること

4. **レビュー結果をコメント**
   - レビュー結果をPRにコメント
   - `GH_PAGER= gh pr comment <PR番号> --body "レビュー結果..."`
   - コメント内容：
     - 判定：✅ マージOK / ⚠️ 修正が必要
     - 良い点：実装の優れている箇所
     - 修正提案：改善が必要な箇所（ある場合）


## 基本ルール

- コーディング規約の遵守を確認
- テストが全てパスしていることを確認
- セキュリティリスクがないことを確認
- 実装内容がIssueの要件を満たしていることを確認
