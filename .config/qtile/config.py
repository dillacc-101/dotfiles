# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

from os import listdir
from os import path
import subprocess
import json


qtile_path = path.join(path.expanduser("~"), ".config", "qtile")


# THEME

theme = "test" # only if available in ~/.config/qtile/themes

theme_path = path.join(qtile_path, "themes", theme)

img = {}

# map image name to its path
img_path = path.join(theme_path, "img")
for i in listdir(img_path):
    img[i.split(".")[0]] = path.join(img_path, i)

# KEYS

mod = "mod4"

#          Special  KeyCap  Actions
keys = [Key(key[0], key[1], *key[2:]) for key in [

    # Window keybinds

    ([mod], "Tab", lazy.group.next_window()),
    ([mod, "shift"], "f", lazy.window.toggle_floating()),
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),


    # Switch between windows in current stack pane
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),


    # Change window sizes (MonadTall)
    ([mod, "shift"], "l", lazy.layout.grow()),
    ([mod, "shift"], "h", lazy.layout.shrink()),


    # Switch between layouts

    ([mod], 'x', lazy.group.setlayout('monadtall')),
    ([mod], 'm', lazy.group.setlayout('max')),
    ([mod], 's', lazy.group.setlayout('matrix')),
    ([mod], 'n', lazy.group.setlayout('monadwide')),

    # Qtile defaults 

    ([mod], "w", lazy.window.kill()),
    ([mod, "control"], "r", lazy.restart()),
    ([mod, "control"], "q", lazy.shutdown()),
    ([mod], "r", lazy.spawncmd()),


    # External Applications 
    ([mod], "f", lazy.spawn("thunar")),
    ([mod], "i", lazy.spawn("flameshot gui")),
    ([mod], "p", lazy.spawn("zathura")),
    ([mod], "z", lazy.spawn("zoom")),
    ([mod], "b", lazy.spawn("brave")),
    ([mod], "Return", lazy.spawn("alacritty")),

    # Volume
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    ([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    ))

    ]]


# GROUPS

groups = [Group(i) for i in ["TER", "NET", "DEV", "MEDIA", "MISC"]]

for i, group in enumerate(groups):
    # Each workspace is identified by a number starting at 1
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N (actual_key)
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        # Send window to workspace N (actual_key)
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])

# Layouts

layout_conf = {
    'border_focus': "#8be9fd",
    'border_width': 2,
    'margin': 4
}

layouts = [
    layout.Max(),
    layout.MonadTall(**layout_conf),
    layout.Matrix(columns=2, **layout_conf),
    layout.MonadWide(**layout_conf),
    ]

# Colors :)

color = [["#0a0e14", "#0a0e14"], #Background    [0]
        ["#ebdbb2", "#ebdbb2"], #Foreground     [1] 
        ["#126699", "#126699"], #Current group  [2]
        ["#a91e23", "#a91e23"], #Powerline primary [3]
        ["#126699", "#126699"], #Powerline secondary [4]
        ["#458888", "#458888"], #Window border  [5]
        ["#ffffff", "#ffffff"], #White [6]
        ["#928374", "#928374"], #Gray [7]
        ["#0a0a12", "#0a0a12"], #Black [8]
        ] 

base = {
        'foreground':color[6],
        'background':color[0],
        }

powerline_colors_primary = {
        'background' : color[3],
        'foreground' : color[6],
        }

powerline_colors_secondary = {
        'background': color[4],
        'foreground' : color[6],
        }


# WIDGETS

# Reusable configs for displaying different widgets on different screens


separator = {
    **base,
    'linewidth': 0,
    'padding': 5,
}

group_box = {
   **base,
    'font': 'JetBrains Mono',
    'fontsize': 14,
    'margin_y': 3,
    'margin_x': 0,
    'padding_y': 8,
    'padding_x': 5,
    'borderwidth': 1,
    'active': color[1],
    'inactive': color[1],
    'rounded': False,
    'highlight_method': 'block',
    'this_current_screen_border': color[2],
    'this_screen_border': color[7],
    'other_current_screen_border': color[8],
    'other_screen_border': color[8]
}

window_name = {
    **base,
    'font': 'Ubuntu Bold',
    'fontsize': 11,
    'padding': 5
}

systray = {
    'background': color[0],
    'padding': 5
}

text_box = {
    'font': 'Ubuntu Bold',
    'fontsize': 15,
    'padding': 5
}
current_layout_icon = {
    'scale': 0.65
}

current_layout = {
    'padding': 5
}

clock = {
    'format': '%d / %m / %Y - %H:%M '
}

def workspaces():
    return [
        widget.Sep(**separator),
        widget.GroupBox(**group_box),
        widget.Sep(**separator),
        widget.Prompt(**base),
        widget.WindowName(**window_name)
    ]
def powerline_base():
    return [
        widget.CurrentLayoutIcon(
            **powerline_colors_primary,
            **current_layout_icon
        ),
        widget.CurrentLayout(
            **powerline_colors_primary,
            **current_layout
        ),
        widget.Image(
            filename=img['primary']
        ),
        widget.TextBox(
            **powerline_colors_secondary,
            **text_box,
            text=' 🕒'
        ),
        widget.Clock(
            **powerline_colors_secondary,
            **clock
        )
    ]


laptop_widgets = [
    *workspaces(),

    widget.Sep(
        **separator
    ),
    widget.Systray(
        **systray
    ),
    widget.Sep(
        **separator
    ),
    widget.Image(
        filename=img['bg-to-primary']
    ),
    widget.Battery(
        **powerline_colors_secondary
    ),
    widget.Image(
        filename=img['secondary']
    ),
    *powerline_base()
 ]


widget_defaults = {
    'font': 'Ubuntu Mono',
    'fontsize': 13,
    'padding': 2
}
extension_defaults = widget_defaults.copy()


# SCREENS

screens = [
    Screen(top=bar.Bar(laptop_widgets, 24, opacity=0.85))
]

# check connected monitors

# MOUSE

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]


# OTHER STUFF

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'confirmreset'},  # gitk
        {'wmclass': 'makebranch'},  # gitk
        {'wmclass': 'maketag'},  # gitk
        {'wname': 'branchdialog'},  # gitk
        {'wname': 'pinentry'},  # GPG key password entry
        {'wmclass': 'ssh-askpass'},  # ssh-askpass
    ],
    border_focus=color[5][0]
)
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's lightlist.
wmname = "LG3D"
