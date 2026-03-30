#   ____  _   _ _         _____             __ _       
#  / __ \| | (_) |       / ____|           / _(_)      
# | |  | | |_ _| | ___  | |     ___  _ __ | |_ _  __ _ 
# | |  | | __| | |/ _ \ | |    / _ \| '_ \|  _| |/ _` |
# | |__| | |_| | |  __/ | |___| (_) | | | | | | | (_| |
#  \___\_\\__|_|_|\___|  \_____\___/|_| |_|_| |_|\__, |
#                                                 __/ |
# -By N0AH                                       |___/ 


###############################
###         IMPORTS         ###
###############################

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget as widget_extra
import os
import subprocess

# Append ~/.local/bin to Qtile's PATH
os.environ["PATH"] += os.pathsep + os.path.expanduser("~/.local/bin")


###############################
###        DEFAULTS         ###
###############################

mod = "mod4" # Sets mod key to windows/meta key
alt_mod = "mod1" # Sets an alternate mod key as alt

# Apps from .bash_env (sourced in .xinitrc)
terminal = os.environ.get("TERMINAL")
file_manager = str(os.environ.get("FILE_MGR_FULL"))
browser = str(os.environ.get("BROWSER"))
music = str(os.environ.get("MUSIC"))



###############################
###       KEYBINDINGS       ###
###############################

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),

    # Move windows
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Grow windows
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),

    # Launch:
    Key([mod], "return", lazy.spawn(terminal)),          # terminal
    Key([mod], "q",      lazy.spawn("rofi -show drun")), # app launcher
    Key([mod], "y",      lazy.spawn("flameshot gui")),   # screenshot
    Key([mod], "1",      lazy.spawn(browser)),           # Browser
    Key([mod], "2",      lazy.spawn(file_manager)),      # File manager
    Key([mod], "3",      lazy.spawn(music)),             # Music

    # Commmands
    Key([mod],            "w", lazy.window.kill()),   # Close window
    Key([mod],            "r", lazy.spawncmd()),      # open prompt widget 
    Key([mod, "control"], "r", lazy.reload_config()), # Reload the config
    Key([mod], "t", lazy.window.toggle_floating()),   # Toggle floating

    # Media
    Key([mod], "F12", lazy.spawn("playerctl play-pause")), # Toggle playback
    Key([mod], "F11", lazy.spawn("playerctl next")),       # Play next song"
    Key([mod], "F10", lazy.spawn("playerctl previous")),   # Play last song
    
    # Volume
    Key([mod], # Mute
        "F9",  
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([mod], # Increase
        "F8", 
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%")),
    Key([mod], # Decrease
        "F7",  
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%")),
]

# Switch to tty
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).
            when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


###############################
###         GROUPS          ###
###############################

# Names of groups
groups = [Group(i) for i in "zaxsdcfZAXSDCF"]

# Number of unique groups
unique_groups = 7

for i in groups[:unique_groups]:
    keys.extend(
        [
            # switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # move focused window to group
            Key(
                [mod, "shift"], 
                i.name, 
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)
            ),
        ]
    )

for i in groups[-unique_groups:]:
    keys.extend(
        [
            # switch to group
            Key(
                [alt_mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # move focused window to group
            Key(
                [alt_mod, "shift"], 
                i.name, 
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)
            ),
        ]
    )


###############################
###       COLOR VARS        ###
###############################

colors = {
    "foreground": "#FFFFFF",
    "background": "#00000088",
    "inactive": "#666666", 
    "accent": "#FFFFFF",
}


###############################
###         LAYOUTS         ###
###############################

layouts = [
    layout.Columns(
        border_focus=colors["foreground"],
        border_normal=colors["inactive"],
        border_width=2,
        grow_amount=1,  
        margin=5,
        border_on_single=True,
    ),
]

floating_layout = layout.Floating(
    border_focus=colors["foreground"],
    border_normal=colors["inactive"],
    border_width=2
)


###############################
###        TASKBARS         ###
###############################

widget_defaults = dict(
    font="CaskaydiaMono Nerd Font",
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(

###############################
###         TASKBAR         ###
###############################

        bottom=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method='line',
                    highlight_color=["00000000", "00000000"],
                    this_current_screen_border=colors["foreground"],
                    this_screen_border=colors["foreground"],
                    borderwidth=2,
                    inactive=colors["inactive"],
                    disable_drag=True,
                    other_current_screen_border=colors["inactive"], 
                    other_screen_border=colors["inactive"],
                ),

                widget.Prompt(),

                widget.Spacer(),

                widget.Clock(format="%I:%M %S   %a, %m-%d"),

                widget.Spacer(),

                widget.Volume(),

                widget.TextBox(" "),

                widget.Bluetooth(
                    default_show_battery=True,
                    device_format='{name}{battery_level}'
                ),
            ],
            20,
            border_width=[2, 0, 0, 0],
            border_color=colors["foreground"],
            margin=[0, 0, 2, 0],
            background=colors["background"],
        ),
    ),
]


###############################
###          HOOKS          ###
###############################

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])


###############################
###       OTHER STUFF       ###
###############################

# Drag floating layouts.
mouse = [
    Drag([mod],  "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod],  "Button3", lazy.window.set_size_floating(),     start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=colors["foreground"],
    border_normal=colors["inactive"],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
