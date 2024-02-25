return {
  {
    'echasnovski/mini.starter',
    event = 'VimEnter',
    config = function()
      local logo = table.concat({
        "     _____  .__       .______   ____.__             ",
        "    /     \\ |__| ____ |__\\   \\ /   /|__| _____   ",
        "   /  \\ /  \\|  |/    \\|  |\\   Y   / |  |/     \\  ",
        "  /    Y    \\  |   |  \\  | \\     /  |  |  Y Y  \\ ",
        "  \\____|__  /__|___|  /__|  \\___/   |__|__|_|  / ",
        "          \\/        \\/                       \\/  ",
      }, "\n")
      local plugin_count = #require("lazy").plugins()
      require("mini.starter").setup({
        autoopen = true,
        evaluate_single = true,
        header = logo,
        items = {
          require("mini.starter").sections.builtin_actions(),
          require("mini.starter").sections.pick(),
          require("mini.starter").sections.recent_files(5, false),
          { action = "Lazy",  name = "Lazy",  section = "Plugin Actions" },
          { action = "Mason", name = "Mason", section = "Plugin Actions" },
        },
        footer = table.concat({
          " " .. plugin_count .. " plugins installed",
          " " .. os.date(),
        }, "\n"),
      })
    end,
  },
}
