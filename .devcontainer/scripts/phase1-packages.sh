#!/bin/bash
set -e

# ベースディレクトリを取得
BASE_DIR="$(dirname "$0")/.."

# 関数を読み込む
source "${BASE_DIR}/functions/print_message.sh"
source "${BASE_DIR}/functions/install_apt.sh"
source "${BASE_DIR}/functions/install_npm.sh"

# フェーズ1: 開発環境パッケージのインストール
print_section "フェーズ 1: 開発環境パッケージのインストール"

# aptパッケージのインストール
# 現時点では特に必要なものはないが、将来的に追加される可能性がある
# 例:
# print_subsection "システムパッケージのインストール"
# install_apt_packages \
#     "jq:JSONプロセッサ" \
#     "curl:HTTPクライアント" \
#     "htop:システムモニタ"

# npmグローバルパッケージのインストール
print_subsection "npmグローバルパッケージのインストール"

# 必要なnpmパッケージをインストール
install_npm_globals \
    "ccmanager:Claude Code Manager"

# 将来的に追加されるパッケージの例:
# install_npm_globals \
#     "typescript:TypeScript" \
#     "prettier:コードフォーマッタ" \
#     "@rails/webpacker:Webpack統合"

print_success "開発環境パッケージのインストールが完了しました"