from lookup import *

config.load_autoconfig()

# aliases {{{
c.aliases["mdl"] = f"spawn --output-messages {scripts_dir}/dl-music " + "{url}"
c.aliases["mdlq"] = (
    f"spawn --output-messages {scripts_dir}/dl-music -q " + "{url}"
)
c.aliases["mdld"] = f"spawn --output-messages {scripts_dir}/dl-music -d"

c.aliases["toqr"] = f"spawn --output-messages {scripts_dir}/qrimg " + "{url}"
# }}}

# bindings {{{
config.unbind("J", mode="normal")
config.unbind("K", mode="normal")
config.bind("J", "tab-prev", mode="normal")
config.bind("K", "tab-next", mode="normal")

config.bind("tt", "set-cmd-text -s :tab-take", mode="normal")

config.unbind("gt", mode="normal")
config.bind("gt", "set-cmd-text -sr :tab-focus", mode="normal")

config.bind("gT", "set-cmd-text -sr :tab-select", mode="normal")
# }}}

c.zoom.default = "150%"

# colors {{{

# completion {{{1
c.colors.completion.category.bg = black
c.colors.completion.category.border.bottom = yellow
c.colors.completion.category.border.top = black
c.colors.completion.category.fg = yellow

c.colors.completion.fg = white

c.colors.completion.item.selected.bg = yellow
c.colors.completion.item.selected.border.bottom = black
c.colors.completion.item.selected.border.top = black
c.colors.completion.item.selected.fg = black

c.colors.completion.match.fg = green

c.colors.completion.odd.bg = black
c.colors.completion.even.bg = black

c.colors.completion.scrollbar.fg = white
c.colors.completion.scrollbar.bg = black

# 1}}}

# tabs {{{1
c.colors.tabs.even.bg = black_secondary
c.colors.tabs.odd.bg = black_secondary
c.colors.tabs.odd.fg = white
c.colors.tabs.odd.fg = white

c.colors.tabs.selected.even.bg = black
c.colors.tabs.selected.odd.bg = black
c.colors.tabs.selected.odd.fg = white
c.colors.tabs.selected.odd.fg = white
# 1}}}

# statusbar {{{1
c.colors.statusbar.command.bg = black
c.colors.statusbar.command.fg = white

c.colors.statusbar.normal.bg = black
c.colors.statusbar.normal.fg = white

c.colors.statusbar.insert.bg = blue
c.colors.statusbar.insert.fg = white

c.colors.statusbar.progress.bg = yellow

c.colors.statusbar.url.success.https.fg = green
c.colors.statusbar.url.success.http.fg = green_secondary
c.colors.statusbar.url.fg = white

c.colors.statusbar.url.hover.fg = cyan
c.colors.statusbar.url.error.fg = red
# 1}}}

# error {{{1
c.colors.messages.error.bg = red
c.colors.messages.error.border = red
c.colors.messages.error.fg = white

c.colors.messages.warning.bg = yellow
c.colors.messages.warning.border = yellow
c.colors.messages.warning.fg = black

c.colors.messages.info.bg = black
c.colors.messages.info.border = black
c.colors.messages.info.fg = white
# 1}}}

# webpage {{{1
# 1}}}

# }}}

# completion {{{
c.completion.height = "40%"
c.completion.shrink = True
# }}}

c.confirm_quit = ["downloads", "multiple-tabs"]

c.content.autoplay = False

c.editor.command = ["kitty", "zsh", "-c", "nvim {file}"]
c.downloads.location.directory = "/home/tony/downloads"

# vim:foldmethod=marker
