return {
  { -- echasnovski/mini.pick
    'echasnovski/mini.pick',
    keys = {
      { '<leader>ff',      ':Pick files<CR>',     'Find Files' },
      { '<leader>pg',      ':Pick grep_live<CR>', 'Live Grep' },
      { '<leader>pb',      ':Pick buffers<CR>',   'Find Buffers' },
      { '<leader>ph',      ':Pick oldfiles<CR>',  'Find Oldfiles' },
      { '<leader>ps',      ':Pick symbols<CR>',   'Find Symbols' },
      { '<leader><space>', ':Pick buffers<CR>',   'Find Buffers' },
    },
    config = function()
      require('mini.pick').setup {
        options = {
          content_from_bottom = false,
          use_cache = false,
        },
        window = {
          config = {
            relative = 'editor',
            width = vim.opt.columns:get(),
            height = 20,
            col = 0,
            row = vim.opt.lines:get(),
            style = 'minimal',
          },
        },
      }
      MiniPick.registry.oldfiles = function()
        local source = {
          items = vim.v.oldfiles,
          name = 'Oldfiles',
        }
        local oldfiles = MiniPick.start { source = source }
        if oldfiles == nil then
          return
        end
        return oldfiles
      end
      MiniPick.registry.symbols = function()
        local bufnr = vim.fn.bufnr()
        local winnr = vim.fn.winnr()
        local params = vim.lsp.util.make_position_params(0)
        vim.lsp.buf_request(bufnr, 'textDocument/documentSymbol', params, function(err, result, _, _)
          if err then
            return
          end
          if not result or vim.tbl_isempty(result) then
            return
          end
          local locations = vim.lsp.util.symbols_to_items(result or {}, bufnr) or {}
          if vim.tbl_isempty(locations) then
            return
          end
          local source = {
            items = locations,
            name = 'Symbols',
            choose = function(item)
              item.bufnr = bufnr
              MiniPick.default_choose(item)
            end,
          }
          local symbols = MiniPick.start { source = source }
          if symbols == nil then
            return
          end
          return symbols
        end)
      end
    end,
  },
}
