-- NOTE: Plugins can specify dependencies.

-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.

-- Use the `dependencies` key to specify the dependencies of a particular plugin

return { -- Fuzzy Finder (files, lsp, etc)
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  dependencies = {
    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },

  -- snacks.nvim is a plugin that contains a collection of QoL improvements.
  -- One of those plugins is called snacks-picker
  -- It is a fuzzy finder, inspired by Telescope, that comes with a lot of different
  -- things that it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- Two important keymaps to use while in a picker are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Snacks picker. This is really useful to discover what nacks-picker can
  -- do as well as how to actually do it!

  -- [[ Configure Snacks Pickers ]]
  -- See `:help snacks-picker` and `:help snacks-picker-setup`
  ---@type snacks.Config
  opts = {
    lazygit = {
      -- your lazygit configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    -- indent = {
    --   animate = {
    --     enabled = true,
    --   },
    --   scope = {
    --     enabled = true,
    --     only_current = true,
    --   },
    --   chunk = {
    --     enabled = false,
    --     only_current = true,
    --   },
    -- },
    picker = {
      sources = {
        explorer = {
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
        },
      },
      prompt = '❯ ',
      layouts = {
        simple = {
          layout = {
            backdrop = false,
            width = 0.4,
            min_width = 50,
            height = 0.5,
            min_height = 20,
            box = 'vertical',
            border = 'rounded',
            title = '{title}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            { win = 'preview', title = '{preview}', height = 0.4, border = 'top' },
          },
        },
        default = {
          layout = {
            backdrop = false,
          },
        },
        select = {
          layout = {
            height = 0.5,
            width = 0.3,
          },
        },
      },
    },
  },
  -- See `:help snacks-pickers-sources`
  -- stylua: ignore
  keys = {
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp', },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps', },
    { '<leader>sf', function() Snacks.picker.smart() end, desc = '[S]earch [F]iles', },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S]elect Snacks', },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' }, },
    { '<leader>/', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep', },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics', },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume', },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)', },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers', },
    { '<leader>sl', function() Snacks.picker.lines {} end, desc = '[/] Fuzzily search in current buffer', },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files', },
    -- Shortcut for searching your Neovim configuration files
    { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files', },
    -- {
    --   '<leader>e',
    --   function()
    --     Snacks.picker.explorer()
    --   end,
    --   desc = '[E]xplorer',
    -- },
    { '<leader>lg', function() Snacks.lazygit() end, desc = '[L]azy[G]it', },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
