# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### --- ###
### ENV ###
### --- ###
export XDG_CONFIG_HOME="$HOME/.config"
export ORACLE_HOME="/opt/oracle/instantclient_23_5"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/scripts:$PATH"
export PATH="$HOME/.local/bin/lsp:$PATH"
export PATH="$HOME/.local/bin/go/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export GOPATH="$HOME/.local/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$ORACLE_HOME:$PATH"
export LD_LIBRARY_PATH="$ORACLE_HOME"
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"
export LESSCHARSET="utf-8"
export BAT_PAGER="less -RF"
export COLORTERM="truecolor"
export TERM="xterm-256color"
# export XDG_RUNTIME_DIR=/run/user/$UID
# export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
# export DISPLAY=192.168.48.1:0
# export SESSION_MANAGER=local/$(hostname):0
# export GDK_BACKEND=x11

export FZF_DEFAULT_OPTS='--color=fg:#9eabac,fg+:#9eabac,bg:#001419,bg+:#002c38
  --color=hl:#a13c11,hl+:#a13c11,info:#1b6497,marker:#49aef5
  --color=prompt:#b58900,spinner:#29EEDF,pointer:#b58900,header:#859900
  --color=gutter:#001419,border:#7f8e90,separator:#b58900,preview-border:#fdf6e3
  --color=label:#fdf6e3,query:#fdf6e3
  --border="rounded" --border-label="FZF" --border-label-pos="0" --preview-window="border-rounded"
  --padding="1" --margin="1" --prompt=" " --marker=" "
  --pointer="->" --separator="-" --scrollbar="|" --layout="reverse"
  --info="right" --ansi'

zstyle ':fzf-tab:*' fzf-flags\
    --color=fg:#9eabac,fg+:#9eabac,bg:#001419,bg+:#002c38\
    --color=hl:#a13c11,hl+:#a13c11,info:#1b6497,marker:#49aef5\
    --color=prompt:#b58900,spinner:#29EEDF,pointer:#b58900,header:#859900\
    --color=gutter:#001419,border:#7f8e90,separator:#b58900,preview-border:#fdf6e3\
    --color=label:#fdf6e3,query:#fdf6e3\
    --prompt=" " --marker=" "\
    --pointer="->" --separator="-" --scrollbar="|"\
    --bind=tab:down,btab:up,alt-k:toggle+down\

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':completion:*:*:source:*' file-patterns '^*(\.dll)' '*'
# zstyle ':completion:*:*:source:*' file-patterns '*~*.dll' 
zstyle ':completion:*:*:source:*' file-patterns '*~*.dll' '*~*.DLL' '*~*.png'

### ----- ###
### ZINIT ###
### ----- ###
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


### ------- ###
### PLUGINS ###
### ------- ###
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

### ------- ###
### ALIASES ###
### ------- ###
# General
alias ls='ls --color=always'
alias la='ls -lAh'
# Sessions
alias s="sessionizer"
alias sd="erase_sessions"
alias sc="config_session"
alias sl="learn_session"
alias lc="leetcode_nvim"

# fuzzy finding scripts
alias cs="cheatsheet"
alias ex="extractor"
alias ff="file_finder"
alias fw="whole_grep"
alias fd="source better_cd"
alias ed="eraser_dir"
alias er="eraser"

# Tmux Shortcuts
alias ts="tmux new-session -s hemram"
alias tks="tmux kill-server && exit"
alias tls="tmux list-sessions"
alias ta="tmux attach"
alias td="tmux detach"

# Git
alias gs="git status"
alias gb="git_branches"
alias gl="git_logs"
alias hawk_tuah="git push"
alias lg="lazygit"

# Other
alias qr="qrgenerator"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


### ------- ###
### Library ###
### ------- ###
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias md='mkdir -p'




### ------- ###
### History ###
### ------- ###
HISTSIZE=5000
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

eval "$(zoxide init zsh)"

# Completions
# source <(ng completion script)
# source <(kubectl completion zsh)

# Competitive Coding flags
# ulimit -s unlimited
