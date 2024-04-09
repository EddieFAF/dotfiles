return {
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    opts = { use_diagnostic_signs = true },
    -- stylua: ignore
    keys = {
      { '<leader>xx', function() require('trouble').toggle() end, desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xd', function() require('trouble').toggle('document_diagnostics') end, desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xw', function() require('trouble').toggle('workspace_diagnostics') end, desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xq', function() require('trouble').toggle('quickfix') end, desc = 'Quickfix List (Trouble)' },
      { '<leader>xl', function() require('trouble').toggle('loclist') end, desc = 'Location List (Trouble)' },
      { "<f9>", "<cmd>TroubleToggle document_diagnostics<cr>" },
      { 'gR', function() require('trouble').open('lsp_references') end, desc = 'LSP References (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },


}
