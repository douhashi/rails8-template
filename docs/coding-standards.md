# コーディング規約

## 基本方針

このプロジェクトでは、コードの一貫性、可読性、保守性を確保するため、以下のコーディング規約に従います。これらの規約は、プロジェクトの品質を維持し、開発者間のコラボレーションを促進するために設けられています。

## 全般的なガイドライン

- DRY (Don't Repeat Yourself) の原則を守る
- SOLID 原則に従ったコード設計を心がける
- 自己説明的なコードを書く（コメントに頼りすぎない）
- 複雑なロジックには適切なコメントを追加する
- 関数やメソッドは単一責任の原則に従い、1つのタスクのみを実行する
- 命名は明確で、その目的を反映したものにする

## バージョン管理とGit

- 機能開発は feature/ ブランチで行う
- バグ修正は fix/ ブランチで行う
- コミットメッセージは簡潔かつ明確に、現在形で記述する
- PRは小さく保ち、1つの機能または修正に集中する
- PRの説明には変更内容とテスト方法を明記する

## Ruby/Rails コーディング規約

### スタイル

- [RuboCop](https://github.com/rubocop/rubocop) の標準ルールセットに従う
- インデントは2スペースを使用
- 行の長さは最大100文字
- クラス、モジュール、メソッドの定義には空行を入れる
- メソッド名はスネークケース (`calculate_total`)
- クラス名とモジュール名はキャメルケース (`UserProfile`)
- 定数は大文字のスネークケース (`MAX_ATTEMPTS`)
- プライベートメソッドやインスタンス変数の使用は最小限に抑える

### Railsベストプラクティス

- Fat Model, Skinny Controller の原則に従う
- 複雑なビジネスロジックはサービスオブジェクトに抽出する
- バリデーションは適切なモデルに配置する
- N+1クエリ問題を避けるため、積極的に`includes`や`joins`を使用する
- 大規模なコントローラーはConcernに分割する
- `app/services`や`app/queries`などのディレクトリを活用する
- 標準的なRailsの命名規則と構造に従う

### ActiveRecordの使用

- 命名規則: テーブル名は複数形、モデル名は単数形
- 関連付け（`has_many`, `belongs_to`など）は論理的な順序で定義
- スコープはクエリロジックをカプセル化するために使用
- `default_scope`の使用は避ける
- 複雑なクエリは名前付きスコープまたはクエリオブジェクトに抽出

## ViewComponent

- コンポーネント名はその機能を明確に表す
- 1つのコンポーネントは1つの責任のみを持つ
- コンポーネントはできるだけ再利用可能にする
- 大きなコンポーネントは小さなコンポーネントに分割する
- コンポーネントのスタイリングは同コンポーネント内に閉じる
- プレビューは全てのコンポーネントに用意する
- パラメータには適切なデフォルト値を設定する
- パラメータの型は常に定義する
- コンポーネントは自己完結的である必要がある

### コンポーネント構造

```ruby
# app/frontend/components/sample_button/component.rb
class SampleButton::Component < ApplicationViewComponent
  # パラメータを明示的に定義
  option :text
  option :url
  option :variant, default: :primary
  option :disabled, default: false
  
  # ビューヘルパー
  def button_classes
    base_classes = "rounded-md px-4 py-2 font-medium"
    variant_classes = variant_class_map[variant.to_sym] || variant_class_map[:primary]
    "#{base_classes} #{variant_classes} #{disabled_classes}"
  end
  
  private
  
  def variant_class_map
    {
      primary: "bg-blue-500 text-white hover:bg-blue-600",
      secondary: "bg-gray-200 text-gray-800 hover:bg-gray-300",
      danger: "bg-red-500 text-white hover:bg-red-600"
    }
  end
  
  def disabled_classes
    disabled ? "opacity-50 cursor-not-allowed" : ""
  end
end
```

## JavaScript (Stimulus.js)

- コントローラー名はケバブケース (`form-handler`)
- アクション名は明確で、その目的を示す (`submitForm`)
- データ属性はケバブケース (`data-controller="form"`)
- Stimulusコントローラーは単一責任の原則に従う
- グローバル変数の使用は避ける
- イベントリスナーはStimulusのライフサイクルメソッド内で適切に追加・削除する
- 複雑なロジックは分離されたサービスクラスに抽出する

### Stimulusコントローラー例

```javascript
// app/frontend/controllers/form_handler_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "submitButton", "errorMessage"]
  static values = { 
    endpoint: String,
    method: String 
  }
  
  connect() {
    this.setupValidation()
  }
  
  submit(event) {
    event.preventDefault()
    if (this.validateForm()) {
      this.submitForm()
    }
  }
  
  validateForm() {
    // バリデーションロジック
    return true
  }
  
  submitForm() {
    // フォーム送信ロジック
    fetch(this.endpointValue, {
      method: this.methodValue,
      body: new FormData(this.formTarget)
    })
    .then(response => this.handleResponse(response))
    .catch(error => this.handleError(error))
  }
  
  handleResponse(response) {
    // レスポンス処理
  }
  
  handleError(error) {
    // エラー処理
  }
  
  setupValidation() {
    // バリデーション設定
  }
}
```

## CSS (Tailwind)

- タグセレクタより、クラスセレクタを優先する
- コンポーネント間で一貫したデザイントークンを使用する
- カスタムCSSクラスは最小限に抑え、可能な限りTailwindのユーティリティを使用する
- レスポンシブデザインはTailwindのブレークポイント (`sm:`, `md:`, `lg:` など) を使用する
- 複雑なスタイルは `@apply` ディレクティブを使用して抽出する
- 一貫したスペーシングとサイズに Tailwind の設定値を使用する
- 色はTailwindのカラーパレットを使用し、ハードコードされた色値を避ける

## テスト

### RSpec

- 各テストはシナリオごとに分割する
- テスト名は明確かつ説明的にする
- `context` と `describe` を使用して論理的にテストをグループ化する
- テストの前提条件には `before` ブロックを使用する
- Factory Bot を使用してテストデータを作成する
- モックとスタブは適切に使用する
- テスト環境の汚染を避けるため、データベーストランザクションを使用する

### システムテスト

- 重要なユーザージャーニーはシステムテストでカバーする
- セレクタは ID や特定のクラスを使用し、テスト専用の属性 (`data-testid`) が望ましい
- フラッキー（不安定）なテストを避けるため、適切な待機戦略を使用する
- ヘッドレスブラウザでテストを実行する
- スクリーンショットはテスト失敗時に自動的に取得する

### テスト例

```ruby
# spec/frontend/components/sample_button_spec.rb
require "rails_helper"

RSpec.describe SampleButton::Component, type: :component do
  describe "#button_classes" do
    context "when variant is primary" do
      it "returns primary button classes" do
        component = described_class.new(text: "Click me", url: "/", variant: :primary)
        expect(component.button_classes).to include("bg-blue-500")
      end
    end
    
    context "when disabled is true" do
      it "includes disabled classes" do
        component = described_class.new(text: "Click me", url: "/", disabled: true)
        expect(component.button_classes).to include("opacity-50")
      end
    end
  end
  
  describe "rendering" do
    it "renders the button with correct text" do
      render_inline(described_class.new(text: "Test Button", url: "/test"))
      expect(page).to have_text("Test Button")
    end
  end
end
```

## 認可 (Pundit)

- ポリシークラスは対応するモデルと同じ名前にする
- ポリシーメソッドは明確で理解しやすい名前にする
- 複雑な認可ロジックはポリシークラス内のプライベートメソッドに抽出する
- スコープを使用してユーザーがアクセス可能なレコードのみを表示する

### Punitポリシー例

```ruby
# app/policies/user_policy.rb
class UserPolicy < ApplicationPolicy
  def show?
    user == record || user.admin?
  end
  
  def update?
    user == record || user.admin?
  end
  
  def destroy?
    user.admin? && user != record
  end
  
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
  
  private
  
  def admin_or_owner?
    user.admin? || user == record
  end
end
```

## コードレビュー

- PRには少なくとも1人のレビュワーが必要
- レビューでは以下を確認する：
  - コーディング規約への準拠
  - テストの適切性と網羅性
  - パフォーマンスの考慮
  - セキュリティの脆弱性
  - ドキュメントの更新
- フィードバックは建設的で具体的であること
- 修正が必要な場合は、その理由と改善案を提示する

## 継続的インテグレーション

- プッシュごとに自動テストを実行する
- マージ前に以下のチェックを行う：
  - 単体テスト・システムテストの成功
  - コードカバレッジの確認
  - Rubocop による静的解析
  - セキュリティスキャン（Brakeman）
  - パフォーマンスメトリクスの確認

## ドキュメント

- パブリックAPIとカスタムクラスにはドキュメントコメントを付ける
- READMEは常に最新の情報を反映する
- 複雑なロジックやアルゴリズムには、その理由と動作を説明するコメントを追加する
- 重要な決定やアーキテクチャの選択理由はドキュメントに記録する

## パフォーマンス

- データベースクエリの最適化を心がける
- N+1クエリ問題を避ける
- 適切なインデックスを設定する
- キャッシュを効果的に活用する
- 大きなファイルのアップロードには適切な処理を実装する

## セキュリティ

- ユーザー入力は必ず検証・サニタイズする
- SQLインジェクション対策を実装する
- XSS攻撃対策を実装する
- CSRF保護を有効にする
- 機密情報は環境変数で管理する
- 定期的にセキュリティ監査を実行する

---

この規約は、プロジェクトの進化に伴って定期的に見直され、更新されます。開発者全員がこの規約に従うことで、コードベースの品質と一貫性を維持します。
