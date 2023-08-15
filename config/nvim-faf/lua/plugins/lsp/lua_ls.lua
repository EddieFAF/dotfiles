return {
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
        },
        checkThirdParty = false,
      },
    },
  },
}
