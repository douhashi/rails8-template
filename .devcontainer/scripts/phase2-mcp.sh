#!/bin/bash
set -e

# ベースディレクトリを取得
BASE_DIR="$(dirname "$0")/.."

# 関数を読み込む
source "${BASE_DIR}/functions/print_message.sh"

# フェーズ2: MCPサーバのセットアップ
print_section "フェーズ 2: MCPサーバのセットアップ"

# MCPディレクトリのパス
MCPS_DIR="${BASE_DIR}/mcps"

# MCPサーバのインストール
print_subsection "MCPサーバをインストール中..."

for mcp_script in "$MCPS_DIR"/*.sh; do
    if [[ -f "$mcp_script" ]]; then
        print_processing "$(basename "$mcp_script")を処理中..."
        
        # スクリプトを実行可能にする
        chmod +x "$mcp_script"
        
        # スクリプトを実行してMCPをインストール
        if "$mcp_script" >&2; then
            echo -e "${GREEN}    ✓ 完了${NC}"
        else
            print_warning "$(basename "$mcp_script")の実行に失敗しました"
        fi
    fi
done

print_success "MCPサーバのインストールが完了しました"
