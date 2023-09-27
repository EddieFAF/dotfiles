return {
  {
    'echasnovski/mini.statusline',
    version = false,
    lazy = false,
    enabled = true,
    config = function()
      require('mini.statusline').setup {
        content = {
          active = function()
            -- stylua: ignore start
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local spell         = vim.wo.spell and (MiniStatusline.is_truncated(120) and 'S' or 'SPELL') or ''
            local wrap          = vim.wo.wrap and (MiniStatusline.is_truncated(120) and 'W' or 'WRAP') or ''
            local git           = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local searchcount   = MiniStatusline.section_searchcount({ trunc_width = 75 })
            --            local location      = MiniStatusline.section_location({ trunc_width = 75 })
            local location2     = "%7(%l/%3L%):%2c %P"

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                 strings = { mode, spell, wrap } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
              '%<',
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=',
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = 'MoreMsg',                strings = { searchcount } },
              { hl = mode_hl,                  strings = { location2 } },
            })
          end,
        },
        use_icons = false,
        set_vim_settings = false,
        -- vim.cmd 'hi MiniStatuslineModeNormal gui=underline guibg=#98c379 guifg=#282C34',
      }
    end,
  },
}
