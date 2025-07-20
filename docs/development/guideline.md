# コンポーネント設計ガイド

## 基本方針

このプロジェクトでは、ViewComponentを使用したコンポーネントベースのUI設計を採用しています。このガイドラインは、一貫性のある再利用可能なコンポーネントを作成するための指針を提供します。

## コンポーネントの概念

コンポーネントとは、UI内で独立して機能する再利用可能な要素です。以下の特性を持っています：

- **独立性**: 他のコードに依存せず、単独で機能する
- **再利用性**: さまざまなコンテキストで使用できる
- **明確な責任**: 単一の役割または機能を持つ
- **カプセル化**: 内部実装の詳細を隠蔽する

## コンポーネント作成ガイドライン

### 命名規則

- コンポーネント名は明確で具体的な名前を使用する（例：`UserCard`、`NavigationMenu`）
- 名前は機能や役割を表し、その目的がすぐに理解できるものにする
- 複合名詞の場合はキャメルケースで統一する
- コンポーネントのファイル名とディレクトリ名はスネークケースを使用する

### コンポーネントの粒度

- コンポーネントは単一責任の原則に従う
- 再利用できる最小単位で設計する
- 300行以上の大きなコンポーネントは分割を検討する
- 複雑なコンポーネントは小さなコンポーネントの組み合わせで構成する

### コンポーネントの階層

コンポーネントは以下のカテゴリに分類します：

1. **原子コンポーネント**: 最小単位の基本要素（ボタン、入力フィールド、ラベルなど）
2. **分子コンポーネント**: 原子コンポーネントを組み合わせた機能単位（フォームグループ、カードなど）
3. **有機体コンポーネント**: 複数の分子や原子を組み合わせた複合UI（ナビゲーション、フォームセクションなど）
4. **テンプレート**: ページレイアウトを形成するコンポーネント
5. **ページ**: 最終的なユーザー向け画面

### コンポーネント作成コマンド

コンポーネントは以下のコマンドで作成します：

```bash
bin/rails g view_component ComponentName [attributes]
```

例：
```bash
bin/rails g view_component UserCard name email avatar_url
```

このコマンドは以下のファイルを生成します：

- `app/frontend/components/user_card/component.rb`: コンポーネントクラス
- `app/frontend/components/user_card/component.html.erb`: コンポーネントテンプレート
- `app/frontend/components/user_card/preview.rb`: コンポーネントプレビュー
- `spec/frontend/components/user_card_spec.rb`: ユニットテスト
- `spec/system/frontend/components/user_card_spec.rb`: システムテスト

### コンポーネントの構造

標準的なコンポーネントは以下の要素で構成されます：

1. **クラス定義**: コンポーネントのロジックとプロパティを定義
2. **テンプレート**: コンポーネントのHTML構造を定義
3. **プレビュー**: 開発環境でのコンポーネント表示を定義

#### コンポーネントクラス例

```ruby
# app/frontend/components/user_card/component.rb
class UserCard::Component < ApplicationViewComponent
  # コレクション対応の設定
  with_collection_parameter :user
  
  # プロパティ定義
  option :name
  option :email
  option :avatar_url, default: nil
  option :active, default: true
  
  # ヘルパーメソッド
  def status_classes
    if active
      "bg-green-100 border-green-500 text-green-800"
    else
      "bg-gray-100 border-gray-300 text-gray-600"
    end
  end
  
  # イベントハンドラや追加のロジック
  def render?
    name.present?
  end
end
```

#### テンプレート例

```erb
<!-- app/frontend/components/user_card/component.html.erb -->
<div class="user-card <%= status_classes %> p-4 rounded-md border-l-4 mb-4">
  <div class="flex items-center space-x-4">
    <% if avatar_url.present? %>
      <img src="<%= avatar_url %>" alt="<%= name %>" class="w-12 h-12 rounded-full">
    <% else %>
      <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center">
        <span class="text-gray-600 font-bold"><%= name.first %></span>
      </div>
    <% end %>
    
    <div>
      <h3 class="font-bold text-lg"><%= name %></h3>
      <p class="text-gray-600"><%= email %></p>
    </div>
  </div>
  
  <% if content.present? %>
    <div class="mt-3">
      <%= content %>
    </div>
  <% end %>
</div>
```

#### プレビュー例

```ruby
# app/frontend/components/user_card/preview.rb
class UserCard::Preview < ApplicationViewComponentPreview
  # プレビューのデフォルト表示
  def default
    render UserCard::Component.new(
      name: "田中太郎",
      email: "tanaka@example.com"
    )
  end
  
  # アバター付きのプレビュー
  def with_avatar
    render UserCard::Component.new(
      name: "佐藤花子",
      email: "sato@example.com",
      avatar_url: "https://via.placeholder.com/150"
    ) do
      "追加情報をここに表示"
    end
  end
  
  # 非アクティブ状態のプレビュー
  def inactive
    render UserCard::Component.new(
      name: "山田次郎",
      email: "yamada@example.com",
      active: false
    )
  end
end
```

## コンポーネント設計のベストプラクティス

### プロパティ設計

- プロパティは明示的に定義する
- 必須プロパティと任意プロパティを明確に区別する
- デフォルト値は適切に設定する
- プロパティの型と範囲に制約を設ける

### スタイリング

- コンポーネント固有のスタイルはコンポーネント内に閉じ込める
- Tailwindのユーティリティクラスを基本として使用する
- 複雑なスタイルはコンポーネント専用のクラスに抽出する
- レスポンシブデザインに対応する

### テスト戦略

- 各コンポーネントには単体テストとシステムテストを作成する
- プロパティの境界値や特殊ケースをテストする
- レンダリング条件と表示/非表示のロジックをテストする
- インタラクションが含まれる場合はユーザー操作をシミュレートしてテストする

### コンポーネントの再利用

- 類似のコンポーネントは共通の基底コンポーネントを継承する
- スロットやイールドを活用して柔軟な内部構造を提供する
- コンポーネントのバリエーションは明示的に設計する
- 高度なカスタマイズが必要な場合はブロックやプロックを使用する

### コンポーネントドキュメント

- 各コンポーネントには適切なコメントを付ける
- プレビューは様々なユースケースを網羅する
- 複雑なプロパティやオプションは説明を付ける
- 使用例を提供する

## このプロジェクト特有のコンポーネント設計

### 基本UIコンポーネント

Webアプリケーションにおいて重要な以下のコンポーネントを用意します：

1. **Button**: 汎用ボタンコンポーネント
2. **Card**: 情報表示用カードコンポーネント
3. **Form**: フォーム関連コンポーネント群
4. **Navigation**: ナビゲーション関連コンポーネント
5. **Modal**: モーダルダイアログコンポーネント
6. **Alert**: 通知・アラートコンポーネント

### データフロー設計

コンポーネント間のデータフローは以下のパターンに従います：

1. **プロパティによるトップダウンデータフロー**: 親から子へのデータ受け渡し
2. **イベントによるボトムアップ通知**: 子から親への変更通知
3. **Stimulusコントローラーによる状態管理**: 複雑な状態管理とUIロジック
4. **Turbo Streamによるサーバー側更新**: 非同期データ更新とUI反映

### インタラクティブコンポーネント

ユーザー操作を伴うコンポーネントには、Stimulus.jsを統合します：

```ruby
# app/frontend/components/interactive_form/component.rb
class InteractiveForm::Component < ApplicationViewComponent
  option :form_data
  option :current_step, default: 1
  
  def stimulus_controller
    "interactive-form"
  end
  
  def stimulus_values
    {
      current_step: current_step,
      total_steps: form_data.steps.count
    }
  end
end
```

```erb
<!-- app/frontend/components/interactive_form/component.html.erb -->
<div data-controller="<%= stimulus_controller %>"
     data-<%= stimulus_controller %>-current-step-value="<%= current_step %>"
     data-<%= stimulus_controller %>-total-steps-value="<%= form_data.steps.count %>">
  <!-- コンポーネントの内容 -->
</div>
```

## コンポーネントライブラリの構築と活用

### コンポーネントカタログ

Lookbookを使用してコンポーネントカタログを構築します：

- 開発環境では `/dev/lookbook` でアクセス可能
- 各コンポーネントのバリエーションを表示
- プロパティの変更によるコンポーネントの挙動確認
- ドキュメントと使用例の表示

### コンポーネントの発見可能性

- 一貫した命名規則で検索しやすくする
- 関連するコンポーネントはディレクトリでグループ化する
- 用途別にカテゴリ分けする
- 共通コンポーネントと特定用途コンポーネントを区別する

## パフォーマンス最適化

- 大きなコンポーネントはレンダリングキャッシュを活用する
- 不要な再レンダリングを避ける設計にする
- データ取得ロジックは効率的に行う
- コレクションレンダリングは最適化する

```ruby
# キャッシュを活用した例
class UserGallery::Component < ApplicationViewComponent
  with_collection_parameter :user
  
  def cache_key
    "user_card/#{user.id}-#{user.updated_at.to_i}"
  end
  
  def before_render
    # 必要なデータの事前ロード
  end
end
```

## アクセシビリティ対応

- すべてのコンポーネントはWCAGガイドラインに準拠する
- キーボード操作に対応する
- 適切なARIAロールと属性を使用する
- スクリーンリーダー対応のテキスト代替を提供する
- 色のコントラスト比を確保する

---

このガイドラインに従うことで、一貫性があり保守しやすいコンポーネントライブラリを構築し、このプロジェクトのUI開発を効率化します。
