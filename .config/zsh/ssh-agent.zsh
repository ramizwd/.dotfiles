SSH_ENV="$HOME/.ssh/agent-env"

start_agent() {
    echo "Starting ssh-agent..."

    # Start a new agent and store its variables
    ssh-agent -s > "$SSH_ENV"
    chmod 600 "$SSH_ENV"

    # Source the variables into the current shell
    . "$SSH_ENV" > /dev/null
    echo "SSH agent started. PID: $SSH_AGENT_PID"

    # Add key
    ssh-add ~/.ssh/id_ed25519
}

check_agent() {
    echo "Loading ssh-agent variables..."
    . "$SSH_ENV" > /dev/null

    # Check if the agent associated with these vars is still running. If not, start one
    if ! pgrep -f "ssh-agent -s" | grep -q "$SSH_AGENT_PID"; then
        start_agent
    else
        echo "Agent is running. PID: $SSH_AGENT_PID"
    fi
}

# Check if agent is running on git operations
git() {
    # Get the first argument after 'git'
    local git_subcommand="$1"

    # Check if the subcommand requires the SSH agent
    case "$git_subcommand" in
        push|pull|clone|fetch)
            check_agent
            ;;
        *)
            ;;
    esac

    command git "$@"
}
