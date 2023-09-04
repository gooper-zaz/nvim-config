local opt = vim.opt
local buffer = vim.b

-- 行号和相对行号
opt.number = true
opt.relativenumber = true

-- 编码
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
buffer.fileenconding = "utf-8"

opt.scrolloff = 5
opt.sidescrolloff = 5

opt.hlsearch = true
opt.incsearch = true

-- 启用鼠标
opt.mouse:append('a')

-- 剪切板
opt.clipboard:append('unnamedplus')

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.list = true

-- 防止包裹
opt.wrap = false

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 光标行
opt.cursorline = true

-- 外观
opt.termguicolors = true
opt.signcolumn = 'yes'

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 300
    })
  end
})

opt.whichwrap = 'h,l'

opt.updatetime = 300
opt.timeoutlen = 500
