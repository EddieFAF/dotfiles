return {
  'IstiCusi/kicknvim',
  ft = 'kickass',
  config = function()
    require('kicknvim').setup {
      kickass_path = '/mnt/nasgard/download/coding/c64/tools/KickAssembler/KickAss.jar', -- or "kickass" if using a wrapper
      x64_path = '/usr/bin/x64', -- path to your VICE binary
      keys = {
        assemble = '<leader>ka',
        run = '<leader>kr',
      },
    }
  end,
}
