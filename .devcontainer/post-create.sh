#!/bin/bash
set -e

# ベースディレクトリを取得
BASE_DIR="$(dirname "$0")"

# メッセージ出力関数を読み込む
source "${BASE_DIR}/functions/print_message.sh"

# 各フェーズのスクリプトを実行
SCRIPTS_DIR="${BASE_DIR}/scripts"

# フェーズ1: パッケージのインストール
if [[ -f "${SCRIPTS_DIR}/phase1-packages.sh" ]]; then
    chmod +x "${SCRIPTS_DIR}/phase1-packages.sh"
    "${SCRIPTS_DIR}/phase1-packages.sh"
else
    print_error "フェーズ1のスクリプトが見つかりません: ${SCRIPTS_DIR}/phase1-packages.sh"
    exit 1
fi

# フェーズ2: MCPサーバのセットアップ
if [[ -f "${SCRIPTS_DIR}/phase2-mcp.sh" ]]; then
    chmod +x "${SCRIPTS_DIR}/phase2-mcp.sh"
    "${SCRIPTS_DIR}/phase2-mcp.sh"
else
    print_error "フェーズ2のスクリプトが見つかりません: ${SCRIPTS_DIR}/phase2-mcp.sh"
    exit 1
fi

# フェーズ3: Railsアプリケーションのセットアップ
if [[ -f "${SCRIPTS_DIR}/phase3-rails.sh" ]]; then
    chmod +x "${SCRIPTS_DIR}/phase3-rails.sh"
    "${SCRIPTS_DIR}/phase3-rails.sh"
else
    print_error "フェーズ3のスクリプトが見つかりません: ${SCRIPTS_DIR}/phase3-rails.sh"
    exit 1
fi

# 完了メッセージ
print_completion "すべてのセットアップが正常に完了しました！"
