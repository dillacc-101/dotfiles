#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias q='exit'
alias dir='dir --color=al'
alias vdir='vdir --color=al'
alias cl='clear'
alias q='exit'
alias logout='pkill -u dillacc'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias battery="upower -i `upower -e | grep BAT` | grep percentage | sed 's/ * / /g'"
alias brightness='xrandr --output eDP1 --brightness'

PS1='\[\033[1;96m\] \W\[\033[1;33m\] ➜ \[\033[1;97m\] '

export PATH=$PATH:/home/dillacc/bin
xset r rate 300 50

