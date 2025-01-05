######################## Path ########################

PATH="/$HOME/.local/bin:$PATH"

# Add Homebrew (if you are on macOS)
if [[ "$(uname -s)" == "Darwin" ]]; then
    PATH="/opt/homebrew/bin:$PATH"
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
fi

# Add Emacs to the PATH (if it's installed)
emacs_bin="$HOME/.config/emacs/bin"
if [[ -e "${emacs_bin}" ]]; then
    PATH="${emacs_bin}":$PATH
fi

# Add .cargo/bin to the PATH (if it's installed)
cargo_bin="$HOME/.cargo/bin"
if [[ -e "${cargo_bin}" ]]; then
    PATH="${cargo_bin}":$PATH
fi

export PATH

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
alias egrep='grep -E --color=auto --exclude-dir={.git}'
alias fgrep='grep -F --color=auto --exclude-dir={git}'
alias grep='grep --color=auto --exclude-dir={.git}'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias sc='sudo systemctl'
alias jc='sudo journalctl'
alias md='mkdir -p'
alias rd=rmdir

######################## Tools ########################

# lsd
if [[ -x "$(command -v lsd)" ]]; then
    alias ls='lsd -a'
    alias la='lsd -la'
    alias lt='lsd --tree'
fi

# fzf -- dependancy: ripgrep, fd-find
if [[ -x "$(command -v fzf)" ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore --glob "!.git/*"'
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd --type d"
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap"
    source <(fzf --zsh)
fi

# startship
if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init zsh)"
fi

# direnv
if [[ -x "$(command -v direnv)" ]]; then
    eval "$(direnv hook zsh)"
fi

# zoxide
if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

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

######################## Hisc ########################

source "$HOME/theo/secrets/.wldrc"
