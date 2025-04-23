######################## Path ########################

PATH="/$HOME/.local/bin:$PATH"

# Add .cargo/bin to the PATH
cargo_bin="$HOME/.cargo/bin"
if [[ -e "${cargo_bin}" ]]; then
    PATH="${cargo_bin}":$PATH
fi

# Add .bun/bin to the PATH
bun_bin="$HOME/.bun/bin"
if [[ -e ${bun_bin} ]]; then
    PATH="${bun_bin}":$PATH
fi

######################## Config ########################

# ZSH configuration
bindkey -e
export EDITOR=nvim
export LANG=en_US.UTF-8
unsetopt correct_all

# Unified history across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=20000

# Basic aliases
alias nv=nvim
alias grep='grep --color=auto --exclude-dir={.git}'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias md='mkdir -p'

######################## Tools ########################

if_exists() {
    local cmd="$1"
    local action="$2"

    if [[ -x "$(command -v "$cmd")" ]]; then
        eval "$action"
    fi
}

if_exists fzf "
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore --glob \".git/*\"'
    export FZF_DEFAULT_OPTS='--height 40% --reverse'
    export FZF_CTRL_T_COMMAND=\"\$FZF_DEFAULT_COMMAND\"
    export FZF_ALT_C_COMMAND='fd --type d'
    export FZF_CTRL_R_OPTS='--preview \"echo {}\" --preview-window down:3:hidden:wrap'
    source <(fzf --zsh)
"

if_exists lsd '
    alias ls="lsd"
    alias ll="lsd -lg"
    alias la="lsd -lgA"
    alias lt="lsd --tree"
'

if_exists zoxide "$(zoxide init --cmd to zsh)"
if_exists starship "$(starship init zsh)"
if_exists direnv "$(direnv hook zsh)"
if_exists lazygit 'alias lg="lazygit"'
if_exists tmux 'alias tmux="tmux -2"'

######################## Zinit ########################

zinit_path="$HOME/.local/share/zinit"
if [[ ! -f "$zinit_path/zinit.git/zinit.zsh" ]]; then
    echo "Installing Zinit"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" || \
        print -P "%F{160} zinit not found && installing it has failed.%f%b"
fi

source "$zinit_path/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# load plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

######################## OSX ########################

if [[ "$(uname -s)" == "Darwin" ]]; then
    PATH="/opt/homebrew/bin:$PATH"
else
    alias open='xdg-open'
fi

######################## WLD ########################

source "$HOME/Projects/secrets/wldrc"
alias claude="/home/sfikastheo/.claude/local/claude"
