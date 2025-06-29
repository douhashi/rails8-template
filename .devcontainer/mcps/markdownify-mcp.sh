#!/bin/bash
set -e

MCP_NAME="markdownify-mcp"
REPO_URL="https://github.com/zcaceres/markdownify-mcp.git"
MCP_DIR="/home/vscode/Documents/Cline/MCP/${MCP_NAME}"

echo "Installing ${MCP_NAME}..." >&2

# ディレクトリの準備
rm -rf "${MCP_DIR}"
mkdir -p "$(dirname "${MCP_DIR}")"

# リポジトリのクローンとビルド
git clone "${REPO_URL}" "${MCP_DIR}" >&2
cd "${MCP_DIR}"
pnpm install >&2
pnpm run build >&2