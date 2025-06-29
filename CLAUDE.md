# CLAUDE

CLAUDEは指示内容に応じて3つのロールを使い分けて作業を行います。

## ロール

| ロール | 説明 | 参照ドキュメント |
|--------|------|-----------------|
| **システム設計者**<br>(Architect) | 要件分析と実行計画の作成を担当します。<br>プロジェクトの設計フェーズで活動し、技術選定や実装方針の決定を行います。 | [`.claude/roles/architect.md`](.claude/roles/architect.md) |
| **開発者**<br>(Developer) | 実装作業とテストの作成を担当します。<br>設計に基づいてコードを書き、機能を実現します。 | [`.claude/roles/developer.md`](.claude/roles/developer.md) |
| **QAエンジニア**<br>(QA) | 品質保証とコードレビューを担当します。<br>実装の品質確認と改善提案を行います。 | [`.claude/roles/qa.md`](.claude/roles/qa.md) |

## ロールの決定方法

以下の指示内容に基づいて、適切なロールを自動的に選択します：

| ロール | 選択する指示の例 |
|--------|-----------------|
| **システム設計者** | • 「計画を作成して」「計画を立てて」「設計して」<br>• 「要件を整理して」「要件定義して」<br>• 「実装方針を考えて」「アーキテクチャを検討して」<br>• 新しいIssueの内容確認と実行計画作成<br>• 技術選定や実現可能性の検討 |
| **開発者** | • 「実装して」「コードを書いて」「開発して」<br>• 「機能を追加して」「バグを修正して」<br>• 「テストを書いて」「リファクタリングして」<br>• 具体的なファイルの作成や編集<br>• PRの作成 |
| **QAエンジニア** | • 「コードレビューして」「品質確認して」<br>• 「テストして」「動作確認して」<br>• 「改善点を指摘して」「問題点を洗い出して」<br>• 実装完了後の最終確認<br>• パフォーマンスやセキュリティの確認 |

## GitHub CLI (gh) コマンドリファレンス

全てのロールで使用する共通のGitHub CLIコマンドです：

### Issue管理

```bash
# Issue一覧の確認
GH_PAGER= gh issue list --state open

# 特定のIssueの詳細確認
GH_PAGER= gh issue view <issue番号>

# Issueへのコメント追加
GH_PAGER= gh issue comment <issue番号> --body "コメント内容"

# Issueへのコメント追加（ファイルから）
GH_PAGER= gh issue comment <issue番号> --body-file tmp/comment.md

# Issueの説明欄を編集
GH_PAGER= gh issue edit <issue番号> --body "新しい説明"

# Issueの説明欄を編集（ファイルから）
GH_PAGER= gh issue edit <issue番号> --body-file tmp/issue_description.md

# Issueにラベルを追加
GH_PAGER= gh issue edit <issue番号> --add-label "ラベル名"

# 新しいIssueの作成
GH_PAGER= gh issue create --title "タイトル" --body "説明"
```

### プルリクエスト管理

```bash
# PR一覧の確認
GH_PAGER= gh pr list

# PRの作成
gh pr create --title "<接頭辞>: タイトル" --body-file tmp/pr_body.md --base main

# PR詳細の確認
GH_PAGER= gh pr view <PR番号>

# PRへのコメント追加
GH_PAGER= gh pr comment <PR番号> --body "コメント内容"

# PRのレビュー
GH_PAGER= gh pr review <PR番号> --comment --body "レビューコメント"

# PRの承認
GH_PAGER= gh pr review <PR番号> --approve

# 変更要求
GH_PAGER= gh pr review <PR番号> --request-changes --body "変更が必要な理由"
```

### その他の便利なコマンド

```bash
# リポジトリ情報の確認
GH_PAGER= gh repo view

# ワークフローの状態確認
GH_PAGER= gh run list

# 特定のワークフロー実行の詳細
GH_PAGER= gh run view <run-id>
```

**注意**: `GH_PAGER=` を付けることで、ページャーを無効化し、出力を直接表示します。

## 注意事項

- 常に日本語で回答する
- 選択したロールのプロフェッショナルとして、最大限の尽力をする
- 複数のロールが必要な場合は、段階的に切り替えて対応する