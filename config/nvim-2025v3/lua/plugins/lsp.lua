local add, now = MiniDeps.add, MiniDeps.now
local utils = require 'utils'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
-- Diagnostic Config
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
    severity = {
      max = vim.diagnostic.severity.WARN,
    },
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
}
now(function()
  add { source = 'neovim/nvim-lspconfig' }
  vim.lsp.enable {
    -- For example, if `lua-language-server` is installed, use `'lua_ls'` entry
    'lua_ls',
  }
end)
add { source = 'williamboman/mason.nvim' }
--
-- Add documentation for nvim-lua api and plugins
--
add 'folke/neodev.nvim'
require('neodev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

--
-- Mason
--
require('mason').setup()

local function lsp(scope)
  return function()
    MiniExtra.pickers.lsp { scope = scope }
  end
end

local function diagnostic(scope)
  return function()
    MiniExtra.pickers.diagnostic { scope = scope }
  end
end

event.autocmd('LspAttach', {
  group = event.augroup 'LspConfig',
  callback = function(args)
    local buffer = args.buf

    -- vim.lsp.completion.enable(true, 0, buffer, { autotrigger = true })

    keys.maplocal('n', '<Leader>lf', lsp 'definition', 'Go to definitions', buffer)
    keys.maplocal('n', '<Leader>lR', lsp 'references', 'Go to references', buffer)
    keys.maplocal('n', '<Leader>lt', lsp 'type_definition', 'Go to type definitions', buffer)

    keys.maplocal('n', '<Leader>lD', diagnostic 'all', 'Find diagnostic (all)', buffer)
    keys.maplocal('n', '<Leader>ld', diagnostic 'current', 'Find diagnostic (current)', buffer)

    keys.maplocal('n', '<Leader>ls', lsp 'document_symbol', 'Find document symbol', buffer)

    keys.maplocal('n', '<Leader>le', vim.cmd.LspRestart, 'Restart Lsp client', buffer)

    keys.maplocal('n', '<Leader>la', vim.lsp.buf.code_action, 'Code actions', buffer)
    keys.maplocal('n', '<Leader>lr', vim.lsp.buf.rename, 'Rename', buffer)

    keys.maplocal('n', 'H', function()
      vim.diagnostic.open_float(nil, { focus = false })
    end, 'Open diagnostics popup', buffer)
    vim.keymap.set('n', 'gK', function()
      vim.diagnostic.config {
        virtual_text = not vim.diagnostic.config().virtual_text,
      }
    end, { desc = 'Toggle diagnostic' })
  end,
})

vim.keymap.set('n', '<Leader>li', '<cmd>LspInfo<cr>', { desc = 'Show LSP info' })
