#!/bin/bash

rebuild_flag=""
if [[ "$1" == "-r" || "$1" == "--rebuild" ]]; then
  rebuild_flag="--remove-existing-container"
fi

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
command="devcontainer up $rebuild_flag \
    --mount type=bind,source=$nvim_resolved_config_path,target=/home/vscode/.config/container-nvim \
    --mount type=bind,source=$tmux_resolved_config_path,target=/home/vscode/.config/tmux \
    --additional-features='{ \
        \"ghcr.io/duduribeiro/devcontainer-features/neovim:1\": { \"version\": \"stable\" }, \
        \"ghcr.io/duduribeiro/devcontainer-features/tmux:1\": {} \
    }' \
    --workspace-folder ."

eval "$command"
eval "devcontainer exec --remote-env NVIM_APPNAME=container-nvim --workspace-folder . /bin/bash"

