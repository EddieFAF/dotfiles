-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim" },
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

      -- Turn on LSP status information
      require("fidget").setup({
        text = { spinner = "dots_hop" },
        window = { blend = 0 },
        fmt = { max_messages = 3 },
      })

      -- Set up cool signs for diagnostics
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Diagnostic config
      local config = {
        virtual_text = true,
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

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        nmap("<leader>lf", "<cmd>Format<cr>", "Format")

        -- if client.server_capabilities.documentSymbolProvider then
        --   navic.attach(client, bufnr)
        -- end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()

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
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
  },
}
