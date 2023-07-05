
return {
  -- [ranger] file browser
  -- https://github.com/kevinhwang91/rnvimr
  {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    keys = {
      {
        "<leader>r", "<cmd>RnvimrToggle<CR>", desc = "Ranger",
      },
    },
    init = function()
      -- vim.g.rnvimr_vanilla = 1 → Often solves many issues
      vim.g.rnvimr_enable_picker = 1 -- if 1, will close rnvimr after choosing a file.
      vim.g.rnvimr_ranger_cmd = { "ranger", "--cmd=set draw_borders both" } -- by using a shell script like TERM=foot ranger "$@" we can open terminals inside ranger.
      vim.g.rnvimr_draw_border = 1
    end,
  },
}
