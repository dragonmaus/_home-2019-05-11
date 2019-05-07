-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/editorconfig')
require('theme')

vis.events.subscribe(vis.events.INIT, function()
  -- Your global configuration options
  vis:command('set autoindent')
  vis:command('set theme dark-16')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
  -- Your per window configuration options e.g.
  -- vis:command('set number')
  vis:command('set numbers')
  vis:command('set show-newlines')
  vis:command('set show-tabs')
end)
