-- Telescope fuzzy finding (all the things)
return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1,
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
          path_display = { 'smart' },
          mappings = {
            n = {
              ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
            },
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<esc>'] = require('telescope.actions').close,
              ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
            },
          },
          extensions = {
            undo = {
              use_delta = true,
              side_by_side = true,
              entry_format = '󰣜  #$ID, $STAT, $TIME',
              layout_strategy = 'flex',
              mappings = {
                i = {
                  ['<cr>'] = require('telescope-undo.actions').yank_additions,
                  ['§'] = require('telescope-undo.actions').yank_deletions, -- term mapped to shift+enter
                  ['<c-\\>'] = require('telescope-undo.actions').restore,
                },
              },
            },
            live_grep_args = {
              auto_quoting = true,
              mappings = {
                i = {
                  ['<c-\\>'] = require('telescope-live-grep-args.actions').quote_prompt { postfix = ' --hidden ' },
                },
              },
            },
            file_browser = {
              depth = 1,
              auto_depth = false,
              hidden = { file_browser = true, folder_browser = true },
              hide_parent_dir = false,
              collapse_dirs = false,
              prompt_path = false,
              quiet = false,
              dir_icon = '󰉓 ',
              dir_icon_hl = 'Default',
              display_stat = { date = true, size = true, mode = true },
              git_status = true,
            },
          },
          theme = 'dropdown',
          sort_mru = true,
          sorting_strategy = 'ascending',
          color_devicons = true,
          border = true,
          hidden = true,
          wrap_results = true,
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      require('telescope').load_extension 'file_browser'

      local map = require('helpers.keys').map
      map('n', '<leader>fr', require('telescope.builtin').oldfiles, 'Recently opened')
      map('n', '<leader><space>', require('telescope.builtin').buffers, 'Open buffers')
      map('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, 'Search in current buffer')

      map('n', '<leader>ff', require('telescope.builtin').find_files, 'Find Files')
      map('n', '<leader>.', require('telescope.builtin').find_files, 'Find Files')
      map('n', '<leader>fF', '<cmd>Telescope find_files hidden=true cwd=$HOME prompt_title=<~><CR>', 'Find Files HOME')
      map('n', '<leader>sh', require('telescope.builtin').help_tags, 'Show Help Tags')
      map('n', '<leader>sw', require('telescope.builtin').grep_string, 'Search Current word')
      map('n', '<leader>sa', require('telescope.builtin').live_grep, 'Grep all files')
      map('n', '<leader>sd', require('telescope.builtin').diagnostics, 'Show Diagnostics')

      map('n', 'gb', require('telescope.builtin').buffers, 'Goto Buffer')
      -- telescope git commands
      map('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', 'Git Commits')       -- list all git commits (use <cr> to checkout) ["gc" for git commits]
      map('n', '<leader>gfc', '<cmd>Telescope git_bcommits<cr>', 'Commits Current') -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
      map('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', 'List Branches')    -- list git branches (use <cr> to checkout) ["gb" for git branch]
      map('n', '<leader>gs', '<cmd>Telescope git_status<cr>', 'Changes')            -- list current changes per file with diff preview ["gs" for git status]

      map('n', '<C-p>', require('telescope.builtin').keymaps, 'Search keymaps')
      map('n', '<leader>sk', require('telescope.builtin').keymaps, 'Search keymaps')

      -- Undo
      map('n', '<leader>fu', ':Telescope undo<cr>', 'undo tree')
      map('n', '\\', function()
        require('telescope').extensions.live_grep_args.live_grep_args {
          prompt_title = 'grep',
          additional_args = '-i',
        }
      end, 'live grep')

      -- File_Browser
      map('n', '<leader>fb', '<cmd>Telescope file_browser<CR>', 'Filebrowser')
      map('n', '<leader>fB', '<cmd>Telescope file_browser hidden=true cwd="$HOME"<CR>', 'Filebrowser (Home Dir)')
      map('n', '<leader>fd', function()
        require('telescope').extensions.file_browser.file_browser {
          path = vim.fn.stdpath 'config',
        }
      end, 'Filebrowser (Config Dir)')

      require('telescope').load_extension 'undo'
      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'live_grep_args'
    end,
  },
}
