return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    char = '┊',
    show_trailing_blankline_indent = false,
    space_char_blankline = " ",
    buftype_exclude = { "telescope", "terminal", "nofile", "quickfix", "prompt" },
    filetype_exclude = {
      "starter",
      "Trouble",
      "TelescopePrompt",
      "Float",
      "OverseerForm",
      "lspinfo",
      "checkhealth",
      "help",
      "man",
      "",
    },
  },

}
