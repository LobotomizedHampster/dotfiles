from __future__ import (absolute_import, division, print_function)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    cyan, magenta, red, white, default,
    normal, bold, reverse,
    default_colors,
)


class Solarized(ColorScheme):
    progress_bar_color = 6

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg = 7
            if context.selected:
                attr = reverse
            else:
                attr = normal
            if context.empty or context.error:
                fg = 9
            if context.border:
                fg = default
            if context.media:
                if context.image:
                    fg = 5
                else:
                    fg = 3
            if context.container:
                fg = 1
                attr |= bold
            if context.directory:
                fg = 6
                attr |= bold
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                fg = 2
            if context.socket:
                fg = 3
                bg = 4
                attr |= bold
            if context.fifo:
                fg = 2
                bg = 4
                attr |= bold
            if context.device:
                fg = 8
                bg = 11
                attr |= bold
            if context.link:
                fg = 14 if context.good else 9
                attr |= bold
                if context.bad:
                    bg = 8
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, magenta):
                    fg = 7
                else:
                    fg = 1
            if not context.selected and (context.cut or context.copied):
                fg = 8
                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    fg = 11
            if context.badinfo:
                if attr & reverse:
                    bg = 13
                else:
                    fg = 13

            if context.inactive_pane:
                fg = 8

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = 7 if context.bad else 8
                if context.bad:
                    bg = 1
            elif context.directory:
                fg = 6
            elif context.tab:
                fg = 7 if context.good else 8
                bg = 0
            elif context.link:
                fg = 14

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 7
                elif context.bad:
                    fg = 9
                    bg = 0
            if context.marked:
                attr |= bold | reverse
                fg = 8
                bg = 2
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 9
                    bg = 8
            if context.loaded:
                bg = self.progress_bar_color

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 5

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        return fg, bg, attr
