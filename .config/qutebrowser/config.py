c.auto_save.session = True
c.content.cookies.accept = 'no-3rdparty'
c.content.default_encoding = 'utf-8'
c.content.host_blocking.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts']
c.content.host_blocking.whitelist = []
c.downloads.location.suggestion = 'both'
c.downloads.position = 'bottom'
c.editor.command = ['gvim', '-f', '{file}', '-c', 'normal {line}G{column0}l']
c.fonts.completion.category = 'bold 9pt monospace'
c.fonts.completion.entry = '9pt monospace'
c.fonts.debug_console = '9pt monospace'
c.fonts.downloads = '9pt monospace'
c.fonts.hints = 'bold 9pt monospace'
c.fonts.keyhint = '9pt monospace'
c.fonts.messages.error = '9pt monospace'
c.fonts.messages.info = '9pt monospace'
c.fonts.messages.warning = '9pt monospace'
c.fonts.monospace = '"Hack Nerd Font Mono", Hack, monospace'
c.fonts.prompts = '9pt sans-serif'
c.fonts.statusbar = '9pt monospace'
c.fonts.tabs = '9pt monospace'
c.hints.chars = 'aoeuidhtns'
c.scrolling.bar = 'always'
c.tabs.title.format = '{audio}{index}{title_sep}{title}'
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'crates': 'https://crates.io/search?q={}',
    'hackage': 'https://hackage.haskell.org/packages/search?terms={}',
    'hoogle': 'https://www.haskell.org/hoogle/?hoogle={}',
    'scry': 'https://scryfall.com/search?q={}',
}
config.bind('X', 'hint links spawn umpv {hint-url}')
config.bind('x', 'spawn umpv {url}')
config.source('theme.py')
