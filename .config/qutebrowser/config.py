config.source('qutebrowser-themes/themes/onedark.py')
config.load_autoconfig()

c.content.private_browsing = False
c.content.javascript.clipboard = 'access'

c.fonts.default_family = 'Dina Remaster'
c.fonts.default_size = '14pt'


# binds
config.bind('X', 'spawn --userscript add-nextcloud-bookmarks')
config.bind('M', 'hint links spawn umpv {hint-url}')
config.bind('b', 'spawn --userscript bookmark.py')
config.bind('m', 'spawn umpv {url}')
config.bind('p', 'open -p')
config.bind(';M', 'hint --rapid links spawn umpv {hint-url}')
config.bind(';b', 'spawn --userscript bookmark.py')
config.bind('xx', 'config-cycle statusbar.show always never ;; config-cycle tabs.show always never')
config.bind('xs', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always switching')
#  ;;
