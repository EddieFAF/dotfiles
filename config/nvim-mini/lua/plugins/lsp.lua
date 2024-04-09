-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      --      { "j-hui/fidget.nvim" },
      "folke/neodev.nvim",
    },
    lazy = false,
    config = function()
      -- Set up Mason before anything else
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
        },
        automatic_installation = true,
      })

      -- Quick access via keymap
      vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Show Mason" })

      -- Neodev setup before LSP config
      require("neodev").setup()

      -- -- Turn on LSP status information
      -- require("fidget").setup({
      --   text = { spinner = "dots_hop" },
      --   window = { blend = 0 },
      --   fmt = { max_messages = 3 },
      -- })

      -- Set up cool signs for diagnostics
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Diagnostic config
      local config = {
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
          --  format = function(d) return "" end
        },
        signs = {
          active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
      vim.diagnostic.config(config)

      --local navic = require("nvim-navic")

      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        local methods = vim.lsp.protocol.Methods
        local nmap = function(keys, func, desc, mode)
          mode = mode or 'n'
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("<leader>lD", "<cmd>:Pick lsp scope='definition'<cr>", "[G]oto [D]efinition")
        nmap("<leader>fR", "<cmd>:Pick lsp scope='references'<cr>", "References")
        nmap("<leader>lI", "<cmd>:Pick lsp scope='implementation'<cr>", "[G]oto [I]mplementation")
        nmap("<leader>lt", "<cmd>:Pick lsp scope='type_definition'<cr>", "Type Definition")
        --nmap("<leader>ds", "<cmd>:Pick lsp scope='document_symbol'<cr>", "[D]ocument [S]ymbols")
        nmap('<leader>la', [[<Cmd>lua vim.lsp.buf.signature_help()<CR>]], 'Arguments popup')
        nmap('<leader>ld', [[<Cmd>lua vim.diagnostic.open_float()<CR>]], 'Diagnostics popup')
        nmap('<leader>lf', [[<Cmd>:Format<cr>]], 'Format')
        nmap('<leader>li', [[<Cmd>lua vim.lsp.buf.hover()<CR>]], 'Information')
        nmap('<leader>lR', [[<Cmd>lua vim.lsp.buf.references()<CR>]], 'References')
        nmap('<leader>ls', [[<Cmd>lua vim.lsp.buf.definition()<CR>]], 'Source definition')

        nmap('<c-j>', '<cmd>lua vim.diagnostic.goto_next({float={source=true}})<cr>')
        nmap('<c-k>', '<cmd>lua vim.diagnostic.goto_prev({float={source=true}})<cr>')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        nmap("<leader>lf", "<cmd>Format<cr>", "Format")

        -- See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

        -- only if capeable
        if client.supports_method(methods.textDocument_rename) then
          nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
        end

        -- if client.server_capabilities.documentSymbolProvider then
        --   navic.attach(client, bufnr)
        -- end

        if client.supports_method(methods.textDocument_codeAction) then
          nmap('<leader>ca', function()
            require('fzf-lua').lsp_code_actions {
              winopts = {
                relative = 'cursor',
                width = 0.6,
                height = 0.6,
                row = 1,
                preview = { vertical = 'up:70%' },
              },
            }
          end, 'Code actions', { 'n', 'v' })
        end

        local status_ok, highlight_supported = pcall(function()
          return client.supports_method('textDocument/documentHighlight')
        end)
        if not status_ok or not highlight_supported then
          return
        end

        local group_name = 'lsp_document_highlight'
        local ok, hl_autocmds = pcall(vim.api.nvim_get_autocmds, {
          group = group_name,
          buffer = bufnr,
          event = 'CursorHold',
        })

        if ok and #hl_autocmds > 0 then
          return
        end

        vim.api.nvim_create_augroup(group_name, { clear = false })
        vim.api.nvim_create_autocmd('CursorHold', {
          group = group_name,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
          group = group_name,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      --      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Lua
      require("lspconfig")["lua_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
              checkThirdParty = false,
            },
          },
        },
      })

      -- Python
      require("lspconfig")["pylsp"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              flake8 = {
                enabled = true,
                maxLineLength = 88, -- Black's line length
              },
              -- Disable plugins overlapping with flake8
              pycodestyle = {
                enabled = false,
              },
              mccabe = {
                enabled = false,
              },
              pyflakes = {
                enabled = false,
              },
              -- Use Black as the formatter
              autopep8 = {
                enabled = false,
              },
            },
          },
        },
      })
    end,
  },
  -- {
  --   "j-hui/fidget.nvim",
  --   tag = "legacy",
  -- },
}
