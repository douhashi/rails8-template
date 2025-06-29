# 開発者（Developer）向けガイドライン

このドキュメントは、CLAUDEが開発者として行動する際のガイドラインです。

## 役割と責任

開発者として、以下の責任を担います：

1. **実装作業**
   - 実行計画に基づいた正確な実装
   - 既存のコードスタイルとパターンの遵守
   - 効率的で保守しやすいコードの作成

2. **テスト作成**
   - ユニットテストの実装
   - システムテストの実装
   - テスト実行と確認

3. **ドキュメント作成**
   - 必要に応じたコードコメント
   - 複雑なロジックの説明
   - API仕様の記載

## 開発ワークフロー

### 1. ブランチ作成

実装開始前に適切な接頭辞を持つブランチを作成：

```bash
# 新機能追加
git checkout -b feat/#<issue番号>-<機能名>

# バグ修正
git checkout -b fix/#<issue番号>-<バグ名>

# その他の例
git checkout -b docs/#<issue番号>-<ドキュメント名>
git checkout -b style/#<issue番号>-<対象名>
git checkout -b refactor/#<issue番号>-<対象名>
git checkout -b test/#<issue番号>-<テスト名>
git checkout -b chore/#<issue番号>-<作業名>
```

### 2. 実装作業

実行計画に従って実装を進めます。

#### コミットガイドライン

```bash
# コミット前にコードスタイルを整える
rubocop -a

# コミット
git add .
git commit -m "<接頭辞>: コミットメッセージ"
```

コミットメッセージの接頭辞：
- `feat:` 新機能追加 🚀
- `fix:` バグ修正 🐛
- `docs:` ドキュメント更新 📚
- `style:` スタイル調整 💅
- `refactor:` リファクタリング ♻️
- `test:` テスト追加・修正 🧪
- `chore:` 雑務的な変更 🔧

### 3. テスト実行

```bash
# テスト実行
bin/rspec

# 特定のテストファイルを実行
bin/rspec spec/path/to/test_spec.rb

# システムテスト実行
bin/rspec spec/system/
```

### 4. プルリクエスト作成

```bash
# 変更をプッシュ
git push origin <ブランチ名>

# PRテンプレートを作成
# tmp/pr_body.mdに以下の内容を記載
```

PRテンプレート：
```markdown
## 概要
[実装した機能/修正の説明]

## 関連するIssue
fixes #<issue番号>

## 変更内容
- [主な変更点1]
- [主な変更点2]

## テスト結果
- [ ] ユニットテスト実行済み
- [ ] システムテスト実行済み
- [ ] rubocop実行済み

## スクリーンショット（UI変更がある場合）
[該当する場合は画像を添付]

## レビューポイント
[レビュアーに特に確認してほしい点]
```

```bash
# PR作成
gh pr create --title "<接頭辞>: PRのタイトル" --body-file tmp/pr_body.md --base main
```

## コーディングガイドライン

### Ruby/Rails

1. **基本原則**
   - Rubyのイディオムを活用
   - ActiveRecordのベストプラクティスに従う
   - Fat Model, Skinny Controllerの原則

2. **命名規則**
   - クラス名: PascalCase
   - メソッド名: snake_case
   - 定数: UPPER_SNAKE_CASE

3. **コード構造**
   - 単一責任の原則
   - DRY原則
   - 早期リターンの活用

### ViewComponent

1. **コンポーネント作成**
   ```bash
   # 必ずgeneratorを使用
   bin/rails g view_component ComponentName [attributes]
   ```

2. **設計原則**
   - 単一責任の原則
   - 再利用可能な設計
   - プレビューの作成必須

3. **参照ドキュメント**
   - [docs/component-guidelines.md](../../docs/component-guidelines.md)

### JavaScript (Stimulus)

1. **コントローラー設計**
   - 単一責任の原則
   - データ属性の活用
   - Turboとの連携

2. **命名規則**
   - コントローラー名: kebab-case
   - アクション名: camelCase

### CSS (Tailwind)

1. **基本方針**
   - Tailwindユーティリティクラスを優先
   - カスタムCSSは最小限
   - レスポンシブデザインの考慮

2. **クラス順序**
   - レイアウト → スペーシング → タイポグラフィ → 色 → その他

## セキュリティガイドライン

### 絶対に避けるべきこと

1. **機密ファイルの操作**
   - `.env` ファイル
   - `config/credentials.yml.enc`
   - `config/master.key`
   - `*.pem` ファイル

2. **セキュリティ上の注意**
   - APIキーのハードコーディング禁止
   - ユーザー入力の検証必須
   - SQLインジェクション対策
   - XSS対策

## 開発環境

### アプリケーション起動

```bash
# localhost:5100で起動
bin/server
```

### よく使うコマンド

```bash
# マイグレーション実行
bin/rails db:migrate

# ルーティング確認
bin/rails routes

# キャッシュクリア
bin/rails tmp:clear
```

## トラブルシューティング

### 連続でテストが失敗する場合

1. 2回以上連続で失敗したら作業を中断
2. 現在の状況を整理
3. 指示者に報告
4. 問題の根本原因を分析

### エラーハンドリング

1. エラーメッセージを正確に読む
2. スタックトレースから原因箇所を特定
3. 関連するドキュメントを確認
4. 必要に応じて代替案を提示

## 参照ドキュメント

- コーディング規約: [docs/coding-standards.md](../../docs/coding-standards.md)
- 共通ルール: [CLAUDE.md](../../CLAUDE.md)

## チェックリスト

実装作業時の確認事項：

- [ ] 実行計画に従っているか
- [ ] 既存のコードスタイルに合わせているか
- [ ] テストを作成したか
- [ ] rubocop -a を実行したか
- [ ] セキュリティ上の問題はないか
- [ ] パフォーマンス上の問題はないか
