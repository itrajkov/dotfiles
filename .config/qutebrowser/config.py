config.source('qutebrowser-themes/themes/onedark.py')
config.load_autoconfig()

c.content.private_browsing = False
c.content.javascript.clipboard = 'access'

c.fonts.default_family = 'SourceCodeVF'
c.fonts.default_size = '12pt'


# binds
config.bind('p', 'open -p')
config.bind('m', 'spawn umpv {url}')
config.bind('M', 'hint links spawn umpv {hint-url}')
config.bind(';M', 'hint --rapid links spawn umpv {hint-url}')
config.bind('X', 'spawn --userscript add-nextcloud-bookmarks')
config.bind('xx', 'config-cycle statusbar.show always never ;; config-cycle tabs.show always never')
config.bind('xs', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always switching')


config.set('url.default_page', 'https://search.hbubli.cc/')
config.set('url.searchengines', {"DEFAULT": "https://search.hbubli.cc/search?q={}"})
config.set('url.start_pages', ["http://dashy.home"])
config.set('auto_save.session', True)
config.set('tabs.position', 'left')
config.set('tabs.width', '10%')
