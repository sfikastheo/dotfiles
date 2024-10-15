# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from libqtile import hook

from libqtile.layout.xmonad import MonadTall
from libqtile.layout.floating import Floating
from libqtile.config import (
    Click, Drag, Group,
    Key, Match, Screen,
    ScratchPad, DropDown,
    )

from libqtile.lazy import lazy
from themes import nord as theme
from bars import bar1 as bar

# Configure default applications
mod = "mod4"  # Super Key
terminal = "kitty"  # Default Terminal
file_manager = "thunar"  # Default File Manager
browser = "brave"  # Default Browser

# ╔╗╔═╗              ╔╗          ╔╗    
# ║║║╔╝              ║║          ║║    
# ║╚╝╝ ╔══╗╔╗ ╔╗     ║╚═╗╔╗╔═╗ ╔═╝║╔══╗
# ║╔╗║ ║╔╗║║║ ║║╔═══╗║╔╗║╠╣║╔╗╗║╔╗║║══╣
# ║║║╚╗║║═╣║╚═╝║╚═══╝║╚╝║║║║║║║║╚╝║╠══║
# ╚╝╚═╝╚══╝╚═╗╔╝     ╚══╝╚╝╚╝╚╝╚══╝╚══╝
#          ╔═╝║                        
#          ╚══╝                        

# General keybindings
keys = [
    # Window behaviors
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen mode"),
    Key(["control", "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating mode"),
 
    # Switch focus between windows
    Key(["control"], "h", lazy.layout.left(), desc="Move focus to left"),
    Key(["control"], "l", lazy.layout.right(), desc="Move focus to right"),
    Key(["control"], "j", lazy.layout.down(), desc="Move focus down"),
    Key(["control"], "k", lazy.layout.up(), desc="Move focus up"),
    
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
        lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n",
        lazy.layout.normalize(), desc="Reset all window sizes"),

   # Layouts
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # System Controls
    Key([mod], "space", lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout."),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "c", lazy.shutdown(), desc="Shutdown Qtile"),
]

# Layout specific keybindings
keys.extend([

    # MonadTall Layout
    Key(["control", "shift"], "h",
        lazy.layout.swap_left(), desc="Move window to the left"),
    Key(["control", "shift"], "l",
        lazy.layout.swap_right(), desc="Move window to the right"),
    Key(["control", "shift"], "j",
        lazy.layout.shuffle_down(), desc="Move window down"),
    Key(["control", "shift"], "k",
        lazy.layout.shuffle_up(), desc="Move window up"),
    Key(["control", "shift"], "space",
        lazy.layout.flip(), desc="Flip layout"),

    Key([mod, "control"], "i",
        lazy.layout.grow(), desc="Increase window size"),
    Key([mod, "control"], "m",
        lazy.layout.shrink(), desc="Decrease window size"),
    Key([mod, "control"], "o",
        lazy.layout.maximize(), desc="Toggle minimum and maximum sizes"),
])

# Set up Monitor navigation
def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)

keys.extend([
    # Move windows between monitors
    Key([mod,"shift"], "l", lazy.function(window_to_next_screen, switch_screen=True)),
    Key([mod,"shift"], "h", lazy.function(window_to_previous_screen, switch_screen=True)),
    
    # Change focus between monitors
    Key([mod], 'l', lazy.next_screen(), desc='Focus next monitor'),
    Key([mod], 'h', lazy.prev_screen(), desc='Focus previous monitor'),
])

# Application specific keybindings
keys.extend([

    Key([mod, "shift"], "s",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/screen_area_clip.sh")),
        desc="Save screenshot to clipboard"),

    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "e", lazy.spawn(file_manager), desc="Launch file manager"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    
    Key(["control"], "space",
        lazy.spawn(os.path.expanduser("~/.config/qtile/scripts/rofi-applauncher.sh")),
        desc="Launch rofi dmenu"),
])


# ╔═══╗                   
# ║╔═╗║                   
# ║║ ╚╝╔═╗╔══╗╔╗╔╗╔══╗╔══╗
# ║║╔═╗║╔╝║╔╗║║║║║║╔╗║║══╣
# ║╚╩═║║║ ║╚╝║║╚╝║║╚╝║╠══║
# ╚═══╝╚╝ ╚══╝╚══╝║╔═╝╚══╝
#                 ║║      
#                 ╚╝      

groups = [Group(i) for i in ["", "", "󰨞", "", "󱖬", "󰒓"]]
group_hotkeys = "123456"

for g, k in zip(groups, group_hotkeys):
    keys.extend(
        [
            # Switch to group
            Key([mod], k,
                lazy.group[g.name].toscreen(),
                desc=f"Switch to group {g.name}",
            ),
         
            # Switch to & move focused window to group
            Key([mod, "shift"], k,
                lazy.window.togroup(g.name, switch_group=True),
                desc=f"Switch to & move focused window to group {g.name}",
            ),
            
            # Switch to group relatively
            Key([mod], "k", lazy.screen.next_group(), desc="Switch to next group"),
            Key([mod], "j", lazy.screen.prev_group(), desc="Switch to previous group"),
        ]
    )


# ╔═══╗                ╔╗       ╔═══╗       ╔╗    
# ║╔═╗║                ║║       ║╔═╗║       ║║    
# ║╚══╗╔══╗╔═╗╔══╗ ╔══╗║╚═╗     ║╚═╝║╔══╗ ╔═╝║╔══╗
# ╚══╗║║╔═╝║╔╝╚ ╗║ ║╔═╝║╔╗║╔═══╗║╔══╝╚ ╗║ ║╔╗║║══╣
# ║╚═╝║║╚═╗║║ ║╚╝╚╗║╚═╗║║║║╚═══╝║║   ║╚╝╚╗║╚╝║╠══║
# ╚═══╝╚══╝╚╝ ╚═══╝╚══╝╚╝╚╝     ╚╝   ╚═══╝╚══╝╚══╝
                                                
groups.append(
    ScratchPad(
        'scratchpad',
        [
            DropDown(
                'terminal', 'kitty',
                width=0.5, height=0.7,
                x=0.25, y=0.1,
                opacity=1
            ),
            DropDown(
                'audio', 'pavucontrol',
                width=0.4, height=0.6,
                x=0.3, y=0.1,
                opacity=1
            ),
        ]
    )
)

keys.extend([
    Key(["control"], "1", lazy.group['scratchpad'].dropdown_toggle('audio')),
    Key(["control"], "2", lazy.group['scratchpad'].dropdown_toggle('terminal')),
])                                               


# ╔═╗╔═╗                
# ║║╚╝║║                
# ║╔╗╔╗║╔══╗╔╗╔╗╔══╗╔══╗
# ║║║║║║║╔╗║║║║║║══╣║╔╗║
# ║║║║║║║╚╝║║╚╝║╠══║║║═╣
# ╚╝╚╝╚╝╚══╝╚══╝╚══╝╚══╝

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


# ╔╗                    ╔╗     
# ║║                   ╔╝╚╗    
# ║║ ╔══╗ ╔╗ ╔╗╔══╗╔╗╔╗╚╗╔╝╔══╗
# ║║ ╚ ╗║ ║║ ║║║╔╗║║║║║ ║║ ║══╣
# ║╚╗║╚╝╚╗║╚═╝║║╚╝║║╚╝║ ║╚╗╠══║
# ╚═╝╚═══╝╚═╗╔╝╚══╝╚══╝ ╚═╝╚══╝
#         ╔═╝║                 
#         ╚══╝                 

# First item in this list is the default.
layouts = [
    MonadTall(
        border_normal=theme['black'],
        border_focus=theme['cyan'],
        margin=10,
        border_width=2,
        single_border_width=2,
        single_margin=10,
    ),
 
]

floating_layout = Floating(
    border_normal=theme['black'],
    border_focus=theme['cyan'],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry

        Match(title="blueman-manager"),
        Match(title="pavucontrol"),
    ]
)


# ╔╗╔╗╔╗    ╔╗         ╔╗     
# ║║║║║║    ║║        ╔╝╚╗    
# ║║║║║║╔╗╔═╝║╔══╗╔══╗╚╗╔╝╔══╗
# ║╚╝╚╝║╠╣║╔╗║║╔╗║║╔╗║ ║║ ║══╣
# ╚╗╔╗╔╝║║║╚╝║║╚╝║║║═╣ ║╚╗╠══║
#  ╚╝╚╝ ╚╝╚══╝╚═╗║╚══╝ ╚═╝╚══╝
#             ╔═╝║            
#             ╚══╝            

widget_defaults = dict(
    font="FiraCode Nerd Font Mono",
    fontsize=13,
    padding=10,
)
extension_defaults = widget_defaults.copy()


# ╔═══╗                       
# ║╔═╗║                       
# ║╚══╗╔══╗╔═╗╔══╗╔══╗╔═╗ ╔══╗
# ╚══╗║║╔═╝║╔╝║╔╗║║╔╗║║╔╗╗║══╣
# ║╚═╝║║╚═╗║║ ║║═╣║║═╣║║║║╠══║
# ╚═══╝╚══╝╚╝ ╚══╝╚══╝╚╝╚╝╚══╝
                            
# Multiple screens can be handled using
# multiple screen objects. 
# In X11 you can list screens with: 
# xrandr --listmonitors. THe order of
# the output is the order of the screens
 
screens = [
    Screen(top=bar),
]
                         

# ╔╗╔╗╔╗╔═╗╔═╗     ╔═══╗     ╔╗  ╔╗               
# ║║║║║║║║╚╝║║     ║╔═╗║    ╔╝╚╗╔╝╚╗              
# ║║║║║║║╔╗╔╗║     ║╚══╗╔══╗╚╗╔╝╚╗╔╝╔╗╔═╗ ╔══╗╔══╗
# ║╚╝╚╝║║║║║║║╔═══╗╚══╗║║╔╗║ ║║  ║║ ╠╣║╔╗╗║╔╗║║══╣
# ╚╗╔╗╔╝║║║║║║╚═══╝║╚═╝║║║═╣ ║╚╗ ║╚╗║║║║║║║╚╝║╠══║
#  ╚╝╚╝ ╚╝╚╝╚╝     ╚═══╝╚══╝ ╚═╝ ╚═╝╚╝╚╝╚╝╚═╗║╚══╝
#                                         ╔═╝║    
#                                         ╚══╝    

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
# wl_input_rules = None

# Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits;
# Set this string if your java app doesn't work correctly.
wmname = "LG3D"


# ╔═══╗     ╔╗          ╔═══╗ ╔╗          ╔╗ 
# ║╔═╗║    ╔╝╚╗         ║╔═╗║╔╝╚╗        ╔╝╚╗
# ║║ ║║╔╗╔╗╚╗╔╝╔══╗     ║╚══╗╚╗╔╝╔══╗ ╔═╗╚╗╔╝
# ║╚═╝║║║║║ ║║ ║╔╗║╔═══╗╚══╗║ ║║ ╚ ╗║ ║╔╝ ║║ 
# ║╔═╗║║╚╝║ ║╚╗║╚╝║╚═══╝║╚═╝║ ║╚╗║╚╝╚╗║║  ║╚╗
# ╚╝ ╚╝╚══╝ ╚═╝╚══╝     ╚═══╝ ╚═╝╚═══╝╚╝  ╚═╝

@hook.subscribe.startup_once
def autostart():
    bar.window.window.set_property("QTILE_BAR", 1, "CARDINAL", 32)
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.run([home])

