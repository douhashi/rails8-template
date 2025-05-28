#!/bin/bash
set -e

# setup Rails app
bin/setup --skip-server

# パス設定
TARGET_DIR="/home/vscode/Documents/Cline/MCP"
REPO_URL="https://github.com/zcaceres/markdownify-mcp.git"
REPO_NAME="markdownify-mcp"
REPO_PATH="${TARGET_DIR}/${REPO_NAME}"
SETTINGS_FILE="/home/vscode/.vscode-server/data/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json"

# markdownify-mcp のインストール
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" && git clone "$REPO_URL"
cd "$REPO_PATH" && pnpm install && pnpm run build

# cline MCP サーバー設定を settings.json に書き込む
mkdir -p "$(dirname "$SETTINGS_FILE")"
cat <<EOF > "$SETTINGS_FILE"
{
  "mcpServers": {
    "github.com/zcaceres/markdownify-mcp": {
      "command": "node",
      "args": [
        "/home/vscode/Documents/Cline/MCP/markdownify-mcp/dist/index.js"
      ],
      "disabled": false,
      "autoApprove": [
        "webpage-to-markdown",
        "pdf-to-markdown"
      ],
      "env": {
        "UV_PATH": "/home/vscode/.local/bin/uv"
      }
    }
  }
}
EOF
