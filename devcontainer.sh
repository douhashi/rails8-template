#!/bin/bash

# devcontainerを起動する関数
up_devcontainer() {
    local additional_flags="$1"
    
    # Get the Neovim config path using headless nvim
    nvim_config_path=$(nvim --headless -c 'lua io.stdout:write(vim.fn.stdpath("config"))' -c 'q' --clean)
    
    # Resolve symlink for the config path
    nvim_resolved_config_path=$(readlink -f "$nvim_config_path")
    echo "Resolved nvim config path: $nvim_resolved_config_path"
    
    # Get the tmux config path
    tmux_config_path=~/.config/tmux
    tmux_resolved_config_path=$(readlink -f "$tmux_config_path")
    echo "Resolved config path: $tmux_resolved_config_path"
    
    # Construct the command to run the devcontainer
    # TODO: resolve config dir
    command="devcontainer up $additional_flags"
    
    # Add mount options
    command+=" --mount type=bind,source=$nvim_resolved_config_path,target=/home/vscode/.config/container-nvim"
    command+=" --mount type=bind,source=$tmux_resolved_config_path,target=/home/vscode/.config/tmux"
    
    # Add SSH agent socket mount if it exists
    if [ -S "/tmp/ssh-agent.sock" ]; then
        echo "SSH agent socket found at /tmp/ssh-agent.sock"
        command+=" --mount type=bind,source=/tmp/ssh-agent.sock,target=/tmp/ssh-agent.sock"
    fi
    
    # Add additional features
    command+=" --additional-features='{ \
            \"ghcr.io/duduribeiro/devcontainer-features/neovim:1\": { \"version\": \"stable\" }, \
            \"ghcr.io/duduribeiro/devcontainer-features/tmux:1\": {} \
        }'"
    
    # Add workspace folder
    command+=" --workspace-folder ."
    
    eval "$command"
}

# devcontainerに接続する関数
exec_devcontainer() {
    # Prepare exec command with environment variables
    exec_command="devcontainer exec --remote-env NVIM_APPNAME=container-nvim"
    
    # Add SSH_AUTH_SOCK if the socket was mounted
    if [ -S "/tmp/ssh-agent.sock" ]; then
        exec_command+=" --remote-env SSH_AUTH_SOCK=/tmp/ssh-agent.sock"
    fi
    
    exec_command+=" --workspace-folder . /bin/bash"
    
    eval "$exec_command"
}

# コマンドラインの最初の引数を取得
COMMAND="$1"

# デフォルトはupコマンド
if [ -z "$COMMAND" ]; then
    COMMAND="up"
fi

# コマンドに応じて処理を分岐
case "$COMMAND" in
    up)
        # upコマンドの実装（起動して接続）
        up_devcontainer ""
        exec_devcontainer
        ;;
        
    rebuild)
        # rebuildコマンドの実装（--remove-existing-containerフラグ付きで起動のみ）
        up_devcontainer "--remove-existing-container"
        ;;
        
    down)
        # downコマンドの実装
        echo "Stopping devcontainer..."
        
        # devcontainer.jsonからプロジェクト名を取得
        if [ -f ".devcontainer/devcontainer.json" ]; then
            # jqがインストールされている場合は使用、なければgrepとsedで取得
            if command -v jq >/dev/null 2>&1; then
                # コメントを除去してからjqで処理（JSON5形式のコメントに対応）
                project_name=$(grep -v '^\s*//' .devcontainer/devcontainer.json | jq -r '.name // empty' 2>/dev/null)
            fi
            
            # jqで失敗した場合、またはjqがない場合はgrepで取得
            if [ -z "$project_name" ]; then
                # devcontainer.jsonから"name"フィールドを抽出
                project_name=$(grep -Po '"name"\s*:\s*"\K[^"]+' .devcontainer/devcontainer.json 2>/dev/null)
            fi
        fi
        
        # プロジェクト名が取得できない場合は、compose.yamlから取得を試みる
        if [ -z "$project_name" ] && [ -f ".devcontainer/compose.yaml" ]; then
            project_name=$(grep -Po '^name:\s*"\K[^"]+' .devcontainer/compose.yaml 2>/dev/null)
        fi
        
        # それでも取得できない場合は、ディレクトリ名を使用
        if [ -z "$project_name" ]; then
            project_name=$(basename "$(pwd)")
            echo "Warning: Could not determine project name from devcontainer.json, using directory name: $project_name"
        fi
        
        echo "Project name: $project_name"
        
        # docker composeで管理されているコンテナを停止
        cd .devcontainer 2>/dev/null || true
        if [ -f "compose.yaml" ] || [ -f "compose.yml" ]; then
            docker compose -p "$project_name" down
        else
            # compose.yamlが見つからない場合は、個別にコンテナを停止
            echo "compose.yaml not found, stopping containers individually..."
            docker ps -a --format "{{.Names}}" | grep "^${project_name}-" | while read -r container_name; do
                echo "Stopping container: $container_name"
                docker stop "$container_name"
                docker rm "$container_name"
            done
        fi
        cd - >/dev/null 2>&1 || true
        
        echo "Devcontainer stopped."
        ;;
        
    *)
        echo "Usage: $0 [up|rebuild|down]"
        echo "  up      - Start devcontainer and connect to it (default)"
        echo "  rebuild - Rebuild and start devcontainer"
        echo "  down    - Stop and remove devcontainer"
        exit 1
        ;;
esac

