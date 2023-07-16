local M = {

  {
    'folke/flash.nvim',
    enabled = true,
    event = 'VeryLazy',
    opts = {
      label = {
        -- format = function(opts)
        --   return { { opts.match.label:upper(), opts.hl_group } }
        -- end,
      },
      modes = {
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
            -- format = function(opts)
            --   local label = opts.match.label
            --   if opts.after then
            --     label = label .. ">"
            --   else
            --     label = "<" .. label
            --   end
            --   return { { label, opts.hl_group } }
            -- end,
          },
        },
      },
      -- search = { mode = "fuzzy" },
      -- labels = "��������������",
    },
  },
}

return M
