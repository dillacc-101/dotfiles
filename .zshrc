# trimste

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[blue]%} %1~%{$fg[yellow]%} ➜ %{$reset_color%} "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# aliases
alias ls='ls --color=auto'
alias q='exit'
alias dir='dir --color=al'
alias vdir='vdir --color=al'
alias cl='clear'
alias q='exit'
alias logout='pkill -u dillacc'
alias grep='grep --color=auto'
#alias vim='nvim'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias battery="upower -i `upower -e | grep BAT` | grep percentage | sed 's/ * / /g'"
alias brightness='xrandr --output eDP1 --brightness'
alias r='ranger'
alias pacman='pacman --color always'
alias cfiles='cd .config/'
alias zfl='cd .config/zsh'
alias zshrc='nvim .config/zsh/.zshrc'
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

export EDITOR='nvim'
export VISUAL='nvim'
export TERM='alacritty'
export BROWSER='brave'
export PATH=$PATH:/home/dillacc/.bin
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export GTK2_RC_FILES="$HOME/.config/gtk-2.0"
export PASSWORD_STORE_DIR="$HOME/.local/share/.password-store"
export ZDOTDIR="$HOME/.config/zsh"

pfetch
autoload -Uz promptinit
promptinit

# Load zsh-syntax-highlighting; should be last.
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Apollo theme
#source /home/dillacc/sources/apollo-zsh-theme/apollo-zsh-theme.zsh 

#Syntax highlighting 
source ~/sources/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
