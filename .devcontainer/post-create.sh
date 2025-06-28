#!/bin/bash
set -e

# Install jq if not already installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    sudo apt-get update && sudo apt-get install -y jq
fi

# Set Python environment for node-gyp
export PYTHON=/usr/bin/python3
export npm_config_python=/usr/bin/python3

# Install ccmanager globally
echo "Installing ccmanager..."
npm install -g ccmanager

# setup Rails app
bin/setup --skip-server

# MCP設定ファイルのパス
SETTINGS_FILE="/home/vscode/.vscode-server/data/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json"
MCPS_DIR="$(dirname "$0")/mcps"

# 設定ファイル用のディレクトリを作成
mkdir -p "$(dirname "$SETTINGS_FILE")"

# 空のJSONオブジェクトから開始
echo '{"mcpServers": {}}' > "$SETTINGS_FILE"

# MCP設定を収集
echo "Installing MCP servers..."

for mcp_script in "$MCPS_DIR"/*.sh; do
    if [[ -f "$mcp_script" ]]; then
        echo "Processing $(basename "$mcp_script")..."
        
        # スクリプトを実行可能にする
        chmod +x "$mcp_script"
        
        # スクリプトを実行して設定を取得
        config=$("$mcp_script" 2>&1 | grep -A 1000 '^{' | jq -c '.')
        
        if [[ -n "$config" && "$config" != "null" ]]; then
            # jqを使って設定をマージ
            jq '.mcpServers += '"$config" "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
        fi
    fi
done

# 最終的なJSONをフォーマット
jq '.' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"

echo "MCP servers installation completed."