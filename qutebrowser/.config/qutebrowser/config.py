config.load_autoconfig()

# bindings {{{
config.unbind('J', mode='normal')
config.unbind('K', mode='normal')
config.bind('J', 'tab-prev', mode='normal')
config.bind('K', 'tab-next', mode='normal')
# }}}
