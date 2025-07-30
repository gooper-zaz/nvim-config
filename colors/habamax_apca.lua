-- colors/habamax_apca.lua

vim.cmd('highlight clear')
vim.cmd('syntax reset')

vim.g.colors_name = 'habamax_apca'

-- 默认为 dark 模式
vim.o.background = 'dark'

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- 🎨 颜色方案定义
local palette = {
  dark = {
    bg = '#1a1a1a',
    fg = '#ffffff',
    comment = '#aaaaaa',
    blue = '#66ccff',
    green = '#88cc88',
    red = '#ff6666',
    yellow = '#e0c060',
    cyan = '#60d6c0',
    purple = '#d2a6ff',
    orange = '#ff9933',
    gray = '#888888',
  },
  light = {
    bg = '#ffffff',
    fg = '#1a1a1a',
    comment = '#6a6a6a',
    blue = '#005faf',
    green = '#006a4e',
    red = '#d70000',
    yellow = '#bb6600',
    cyan = '#007777',
    purple = '#5c005c',
    orange = '#aa5500',
    gray = '#999999',
  },
}

local c = palette[vim.o.background] or palette.dark

-- 📄 样式定义（只定义一次，动态取色）
hi('Normal', { fg = c.fg, bg = c.bg })
hi('Comment', { fg = c.comment, italic = true })
hi('LineNr', { fg = c.gray, bg = c.bg })
hi('CursorLineNr', { fg = c.fg, bold = true })

hi('Keyword', { fg = c.blue, bold = true })
hi('Identifier', { fg = c.cyan })
hi('Function', { fg = c.green, bold = true })
hi('String', { fg = c.orange })
hi('Number', { fg = c.purple })
hi('Boolean', { fg = c.red, bold = true })
hi('Operator', { fg = c.fg })
hi('Type', { fg = c.blue, bold = true })

hi('StatusLine', { fg = c.fg, bg = c.gray })
hi('StatusLineNC', { fg = c.comment, bg = c.bg })
hi('VertSplit', { fg = c.gray })
hi('Pmenu', { fg = c.fg, bg = c.bg })
hi('PmenuSel', { fg = c.bg, bg = c.blue })
hi('Visual', { bg = c.gray })
hi('CursorLine', { bg = c.bg })

hi('Error', { fg = c.red, bold = true })
hi('WarningMsg', { fg = c.yellow, bold = true })
hi('DiagnosticError', { fg = c.red })
hi('DiagnosticWarn', { fg = c.yellow })
hi('DiagnosticInfo', { fg = c.blue })
hi('DiagnosticHint', { fg = c.comment })

hi('Title', { fg = c.fg, bold = true })
hi('Underlined', { underline = true })
hi('Todo', { fg = c.red, bg = c.yellow, bold = true })

hi('LspReferenceText', { bg = '#2a2a2a' })
hi('LspReferenceRead', { bg = '#2a2a2a' })
hi('LspReferenceWrite', { bg = '#3a1a1a' })
