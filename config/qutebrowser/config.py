from glob import glob
for a in glob(f'{config.configdir}/config.d/*'):
    config.source(a)

import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
