# Rails 8 テンプレートアプリ Copilot 指示書

このプロジェクトは Rails 8 と View Component を使用した最新のWebアプリケーション開発テンプレートです。コードを提案する際は、以下の原則とガイドラインに従ってください。

## プロジェクト概要

- Rails 8.0.2 ベースのモダンWebアプリケーションテンプレート
- View Component とViteを統合したコンポーネントベース開発環境
- Tailwind CSS 4 を使用したスタイリング
- Haml テンプレートエンジン
- PWA対応の基盤を搭載
- Dockerコンテナ対応のデプロイメント設定

## 技術スタック

### バックエンド
- Ruby on Rails 8.0.2
- PostgreSQL データベース
- Propshaft アセットパイプライン
- Solid系ライブラリ (Solid Cache, Solid Queue, Solid Cable)
- Kamal デプロイメントツール
- Thruster HTTP資産キャッシュ/圧縮ツール
- View Component (コンポーネントベース開発)

### フロントエンド
- Vite ビルドツール
- Tailwind CSS 4
- Hotwire (Turbo, Stimulus)
- JavaScript (ES modules)

### テスト
- RSpec テストフレームワーク
- Capybara システムテスト
- Selenium WebDriver

## コーディング規約

### 全般
- DRY (Don't Repeat Yourself) の原則に従う
- 関心の分離を維持する
- 単一責任の原則を守る
- 名前付けは明示的で説明的にする

### Rubyコード
- RuboCop Rails Omakase のスタイルガイドに準拠
- クラスとメソッドに適切なドキュメンテーションを提供
- 関数型プログラミングのアプローチを優先 (可能な場合)
- `dry-initializer` による初期化パターンを活用

### View Components
- 再利用可能なコンポーネントの開発を推奨
- 各コンポーネントはサイドカーパターンを使用 (component.rb, component.html.haml, preview.rb)
- プレビューでコンポーネントの使用例を示す
- テスト可能なコンポーネント設計

### HTML/CSS
- Haml テンプレートの簡潔な記法を活用
- Tailwind CSS の効率的な活用
- レスポンシブデザインを優先
- アクセシビリティ(WAI-ARIA)を考慮

### JavaScript
- Hotwired (Turbo, Stimulus) ベストプラクティスを遵守
- イベント処理は Stimulus コントローラーに委譲
- ES Modules を使用したモジュール構成

## コンポーネントの開発

新しいコンポーネントを作成する場合:

1. 既存コンポーネントのパターンに従う
2. リプレビューを含む
3. 適切なテストを実装 (ユニットテスト＋システムテスト)
4. 再利用可能性を考慮した設計

例: コンポーネント生成コマンド

```ruby
bin/rails g view_component <ComponentName>
```

## テスト

- すべての新機能には対応するテストを含める
- コンポーネントテストには少なくとも以下を含む:
  - レンダリングテスト
  - プロパティ検証テスト
  - イベント発火テスト (該当する場合)
- システムテストでブラウザ動作を確認

## パフォーマンス考慮事項

- 不要なデータベースクエリを回避
- N+1クエリ問題に注意
- フロントエンド assets のサイズ最適化
- Vite によるコード分割の活用

## セキュリティベストプラクティス

- ユーザー入力は常にサニタイズ
- クロスサイトスクリプティング(XSS)対策の徹底
- CSRF保護の活用
- 適切な権限管理とアクセス制御の実装

## PWA関連

PWA機能を拡張する場合:

- Service Workerを適切に設定
- Manifestファイルを正しく構成
- オフライン機能の実装を検討
- プッシュ通知の統合を検討

## デプロイメント

- Dockerコンテナベースのデプロイメント
- Kamalを使用した本番環境のセットアップ
- 環境固有の設定は環境変数を使用

## 参考文献

- [Rails 8 ガイド](https://guides.rubyonrails.org/)
- [View Component](https://viewcomponent.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [Vite](https://vitejs.dev/)
- [Hotwire](https://hotwired.dev/)