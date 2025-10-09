Hi = function(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local palette = {
  base00_dim = '#232A2E',
  base00 = '#2D353B',
  base01 = '#343F44',
  base02 = '#3D484D',
  base03 = '#475258',
  base04 = '#4F585E',
  base05 = '#D3C6AA',
  base06 = '#7A8478',
  base07 = '#859289',
  base08 = '#E67E80',
  base09 = '#E69875',
  base0A = '#DBBC7F',
  base0B = '#A7C080',
  base0C = '#83C092',
  base0D = '#7FBBB3',
  base0E = '#D699B6',
  base0F = '#9DA9A0',
}

MiniDeps.now(function()
  require('mini.base16').setup {
    palette = palette,
    plugins = { default = true },
  }
  Hi('@constructor.lua', { link = 'Delimiter' })
  Hi('@function.builtin', { link = 'Function' })
  Hi('@lsp.type.parameter', { link = 'Special' })
  Hi('@markup.link.vimdoc', { link = 'Keyword' })
  Hi('@module.builtin', { link = 'Type' })
  Hi('@tag.attribute', { link = 'Statement' })
  Hi('@tag.builtin', { link = 'Tag' })
  Hi('@tag.delimiter', { link = 'Delimiter' })
  Hi('@type.builtin', { link = 'Type' })
  Hi('@variable.member', { link = 'Identifier' })
  Hi('@variable.parameter', { link = 'Special' })
  Hi('CursorLineFold', { link = 'Comment' })
  Hi('CursorLineNr', { link = 'Delimiter' })
  Hi('CursorLineSign', { link = 'Comment' })
  Hi('DiagnosticSignError', { link = 'DiagnosticError' })
  Hi('DiagnosticSignHint', { link = 'DiagnosticHint' })
  Hi('DiagnosticSignInfo', { link = 'DiagnosticInfo' })
  Hi('DiagnosticSignOk', { link = 'DiagnosticOk' })
  Hi('DiagnosticSignWarn', { link = 'DiagnosticWarn' })
  Hi('DiffAdd', { link = 'MiniStatuslineModeVisual' })
  Hi('DiffChange', { link = 'MiniStatuslineModeInsert' })
  Hi('DiffDelete', { link = 'MiniStatuslineModeCommand' })
  Hi('DiffText', { link = 'MiniStatuslineModeReplace' })
  Hi('FloatFooter', { link = 'MiniStatuslineModeVisual' })
  Hi('FloatTitle', { link = 'MiniStatuslineModeVisual' })
  Hi('FoldColumn', { link = 'Comment' })
  Hi('Hlargs', { link = '@variable.parameter' })
  Hi('LineNr', { link = 'Comment' })
  Hi('LineNrAbove', { link = 'Comment' })
  Hi('LineNrBelow', { link = 'Comment' })
  Hi('MiniClueDescGroup', { link = 'Keyword' })
  Hi('MiniClueNextKey', { link = 'Function' })
  Hi('MiniClueNextKeyWithPostkeys', { link = 'Identifier' })
  Hi('MiniClueSeparator', { link = 'FloatBorder' })
  Hi('MiniClueTitle', { link = 'FloatTitle' })
  Hi('MiniCursorword', { bg = palette.base02, fg = palette.base05 })
  Hi('MiniCursorwordCurrent', { bg = palette.base04, fg = palette.base05 })
  Hi('MiniCompletionInfoBorderOutdated', { link = 'Conditional' })
  Hi('MiniDiffOverAdd', { link = 'MiniStatuslineModeVisual' })
  Hi('MiniDiffOverChange', { link = 'MiniStatuslineModeCommand' })
  Hi('MiniDiffOverChangeBuf', { link = 'MiniStatuslineModeVisual' })
  Hi('MiniDiffOverContext', { link = 'MiniStatuslineModeInsert' })
  Hi('MiniDiffOverDelete', { link = 'MiniStatuslineModeCommand' })
  Hi('MiniDiffSignAdd', { link = 'DiagnosticOk' })
  Hi('MiniDiffSignChange', { link = 'DiagnosticHint' })
  Hi('MiniDiffSignDelete', { link = 'DiagnosticError' })
  Hi('MiniFilesTitle', { link = 'FloatTitle' })
  Hi('MiniFilesTitleFocused', { link = 'MiniStatuslineModeCommand' })
  Hi('MiniIndentscopeSymbol', { link = 'SpecialKey' })
  Hi('MiniPickBorderBusy', { link = 'Conditional' })
  Hi('MiniPickBorderText', { link = 'FloatTitle' })
  Hi('MiniPickPrompt', { link = 'MiniStatuslineModeCommand' })
  Hi('MiniPickPromptCaret', { link = 'MiniStatuslineModeCommand' })
  Hi('MiniPickPromptPrefix', { link = 'MiniStatuslineModeCommand' })
  Hi('MiniTablineTabpagesection', { link = 'MiniStatuslineModeVisual' })
  Hi('NormalFloat', { link = 'Normal' })
  Hi('NormalNC', { bg = palette.base00_dim })
  Hi('Operator', { link = 'Delimiter' })
  Hi('QuickFixLineNr', { link = 'SpecialKey' })
  Hi('SignColumn', { link = 'Comment' })
  Hi('TreesitterContext', { link = 'Pmenu' })
  Hi('TreesitterContextLineNumber', { link = 'MiniStatuslineFilename' })
  Hi('WinSeparator', { link = 'Delimiter' })
end)
