-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

local opt = vim.opt

opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.confirm = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
opt.undofile = true
opt.wrap = false
opt.scrolloff = 4
opt.jumpoptions = 'stack'

opt.tabstop = 2
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smoothscroll = true

opt.showmode = false -- 关闭模式显示, 因为有lualine

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen' -- 保持分屏时的滚动位置

opt.fileformats = 'unix,dos,mac' -- 文件格式

opt.backspace = 'indent,eol,start' -- 允许删除缩进,行首,行尾
opt.listchars = { tab = '▸ ', trail = '·', extends = '»', precedes = '«', nbsp = '␣' }

opt.colorcolumn = '100' -- 100列, 我的prettier配置也是100
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode

opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]

vim.filetype.add({
  filename = {
    -- 将git hooks 脚本识别为 shell 脚本
    ['pre-commit'] = 'sh',
    ['commit-msg'] = 'sh',
    ['post-commit'] = 'sh',
    ['pre-push'] = 'sh',
    ['pre-rebase'] = 'sh',
    ['prepare-commit-msg'] = 'sh',
    ['post-push'] = 'sh',
  },
})

-- neovide 配置
if vim.g.neovide then
  -- 轨道动画
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  -- 指定neovide字体
  vim.o.guifont = 'Maple Mono NF CN,LXGW WenKai Mono,JetBrainsMono Nerd Font:h12'
  -- vim.o.guifont = 'Fira Code Nerd Font'
  -- 没有空闲
  vim.g.neovide_no_idle = true

  -- fullscreen
  vim.g.neovide_fullscreen = false

  vim.g.neovide_remember_window_size = true
end
