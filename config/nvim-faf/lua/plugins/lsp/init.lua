local M = {
  'neovim/nvim-lspconfig',
  lazy = false,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
      build = ':MasonUpdate',
      opts = {},
    },
    { 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    { 'hrsh7th/cmp-nvim-lsp' },
    --    {
    --      'j-hui/fidget.nvim',
    --      tag = "legacy",
    --      config = true,
    --    },
    { 'b0o/schemastore.nvim' },
    { 'SmiteshP/nvim-navic' },
  },
}

M.config = function()
  local mason_lsp = require 'mason-lspconfig'
  local lsp = require 'lspconfig'

  require('null-ls').setup {
    sources = { require('null-ls').builtins.formatting.stylua, require('null-ls').builtins.formatting.prettier },
  }
  local setupDiagnostics = function()
    vim.diagnostic.config {
      virtual_text = true,
      update_in_insert = true,
      underline = true,
      float = {
        focusable = true,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
      },
    }

    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
    --    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagonstic window' })
    -- Diagnostic keymaps
    vim.keymap.set('n', 'gx', vim.diagnostic.open_float, { desc = 'Show diagnostics under cursor' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
  end

  setupDiagnostics()

  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
  local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    nmap('<leader>lr', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>la', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>ld', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    if client.supports_method 'textDocument/formatting' then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end

    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, bufnr)
    end
  end

  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn',  text = '' },
    { name = 'DiagnosticSignHint',  text = '' },
    { name = 'DiagnosticSignInfo',  text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  for _, server in ipairs(mason_lsp.get_installed_servers()) do
    local opts = { on_attach = on_attach, capabilities = capabilities }
    local has_custom_opts, server_custom_opts = pcall(require, 'plugins.lsp.' .. server)
    if has_custom_opts then
      opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
    end
    lsp[server].setup(opts)
  end
end

return M
