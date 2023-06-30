return
{
  "SmiteshP/nvim-navic",
  version = false,
  init = function()
    vim.g.navic_silence = true
    end,
  opts = function()
    return {
      separator = " > ",
      depth_limit_indicator = "..",
      safe_output = true,
      click = true,
      highlight = true,
      depth_limit = 5,
    }
  end,
}


