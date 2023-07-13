return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          ["$HOME/.local/share/nvim-faf/lazy/lazy.nvim/lua/lazy/types.lua"] = true,
        },
      },
    },
  },
}
