
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('Z', 'hint links spawn st -e youtube-dl {hint-url}')
config.bind('xb', 'config-cycle statusbar.hide false true')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.hide false true;; config-cycle tabs.show always never')
#config.bind('<Mod4>o', 'spawn --userscript dmenu_qutebrowser')

# Bindings for cycling through CSS stylesheets from Solarized Everything CSS:
# https://github.com/alphapapa/solarized-everything-css
config.bind(',ap', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/apprentice/apprentice-all-sites.css ""')
config.bind(',dr', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/darculized/darculized-all-sites.css ""')
config.bind(',gr', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/gruvbox/gruvbox-all-sites.css ""')
config.bind(',sd', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/solarized-dark/solarized-dark-all-sites.css ""')
config.bind(',sl', 'config-cycle content.user_stylesheets ~/.config/qutebrowser/css/solarized-light/solarized-light-all-sites.css ""')

