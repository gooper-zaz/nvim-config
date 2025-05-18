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

opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.confirm = true

opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.wrap = false
opt.scrolloff = 8

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smoothscroll = true

opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
opt.foldtext = ''

-- neovide 配置
if vim.g.neovide then
  -- 轨道动画
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  -- 指定neovide字体
  vim.o.guifont = 'FiraCode Nerd Font,LXGW WenKai Mono,JetBrainsMono Nerd Font'
  -- vim.o.guifont = 'Fira Code Nerd Font'
  -- 没有空闲
  vim.g.neovide_no_idle = true

  -- fullscreen
  vim.g.neovide_fullscreen = false

  vim.g.neovide_remember_window_size = true
end
