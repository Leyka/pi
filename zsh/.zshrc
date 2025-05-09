# Configure zinit
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Add Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Add Zsh plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# Add Snippets
zinit snippet OMZP::colorize
zinit snippet OMZP::common-aliases
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Load Zsh completions
autoload -Uz compinit && compinit

# Key bindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
zinit light Aloxaf/fzf-tab

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf)"
eval "$(zoxide init --cmd cd zsh)"

# Aliases
alias c='clear'
alias cat='batcat'
alias cx='chmod +x'
alias grep='rg'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'
alias mkdir='mkdir -p'
alias ping='ping -c 4'
alias s='sudo'
alias sz='source ~/.zshrc'
alias top='htop'
alias vim='nvim'
