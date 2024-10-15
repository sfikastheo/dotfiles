from typing import Optional
from libqtile.widget.textbox import TextBox

# All the unicode symbols are from Nerd Fonts
def left_half_circle(fg_color, bg_color: Optional['str'] = None):
    return TextBox(
        text='',
        fontsize=20,
        foreground=fg_color,
        background=bg_color,
        padding=0)

def right_half_circle(fg_color, bg_color: Optional['str'] = None):
    return TextBox(
        text='',
        fontsize=20,
        background=bg_color,
        foreground=fg_color,
        padding=0)
