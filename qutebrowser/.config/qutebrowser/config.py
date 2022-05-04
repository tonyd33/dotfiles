config.load_autoconfig()

# bindings {{{
config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.bind('J', 'tab-prev', mode='normal')
config.bind('K', 'tab-next', mode='normal')
# }}}

c.editor.command = ['kitty', 'zsh', '-c', 'nvim {file}']
c.downloads.location.directory = '/home/tony/downloads'

