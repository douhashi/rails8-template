# Issue #31 計画

## 概要
タスク内で `#<番号>` が指定された場合に、対応する GitHub Issue を必ず確認する旨を開発ガイドラインに追加します。

## 変更箇所
- `.clinerules` の「## 基本ルール」セクション末尾に以下の一行を追記  
  ```
  - タスク内で `#<番号>` が指定された場合は、対応する GitHub Issue を必ず確認してください
  ```

## 実装手順
1. `.clinerules` を編集し、該当箇所に上記文言を追加  
2. コミットメッセージに `docs/#31: .clinerules に Issue 確認ルールを追加` を用いてコミット  
3. `gh issue edit 31 --body-file tmp/plan.md` で Issue 本文に計画を反映  
4. Issue に `ready-for-development` ラベルを追加（`gh issue edit 31 --add-label "ready-for-development"`）

## 完了条件
- `.clinerules` に該当文言が追加されていること  
- Issue #31 の本文が最新の計画を反映していること  
- `ready-for-development` ラベルが付与されていること
