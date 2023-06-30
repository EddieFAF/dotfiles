-- See current buffers at the top of the editor
return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event ="VeryLazy",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
