#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export GTK2_RC_FILES="$HOME/.config/gtk-2.0"
export PASSWORD_STORE_DIR="$HOME/.local/share/.password-store"
export ZDOTDIR="$HOME/.config/zsh"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export GTK_THEME=Ant-Dracula
cbatticon -u 20 -i notification -c "poweroff" -l 25 -r 8 &
xset r rate 300 50 &

# Automont usb, and other devices
udiskie -t &

# Notifications daemon
dunst &
 
# Compositor
picom &

# Background
xwallpaper --zoom .config/wall.jpg
