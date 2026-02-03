-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local util = require('config.util')

util.set_keymap({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, desc = 'Down', silent = true })
util.set_keymap({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, desc = 'Up', silent = true })

-- Select all
util.set_keymap('n', '<C-a>', 'gg<S-v>G', 'Select All')
-- Save
util.set_keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', 'Save')
util.set_keymap({ 'n', 'v' }, '<leader>ww', '<cmd>w<cr><esc>', 'Save')
util.set_keymap({ 'n', 'v' }, '<leader>wa', '<cmd>wa<cr><esc>', 'Save All')
-- Quit
util.set_keymap('n', '<leader>qq', '<cmd>qa<CR>', 'Quit All')
-- Save && Quit
util.set_keymap({ 'n', 'v' }, '<leader>wq', '<cmd>wq<cr>', 'Save && Quit')

-- 向左缩进
util.set_keymap('v', '<', '<gv', 'Indent Left')
-- 向右缩进
util.set_keymap('v', '>', '>gv', 'Indent Right')

util.set_keymap({ 'n', 'v', 'o' }, 'H', '^', 'Start Of Line')
util.set_keymap({ 'n' }, 'L', '$', 'End Of Line')
util.set_keymap({ 'v', 'o' }, 'L', 'g_', 'End Of Line')

-- fast move down/up
util.set_keymap('n', '<C-j>', '10jzz', 'Move down 10 lines')
util.set_keymap('n', '<C-k>', '10kzz', 'Move up 10 lines')

-- Split window
util.set_keymap('n', '<leader>ss', '<cmd>split<Return>', { desc = 'Split Window', noremap = false })
util.set_keymap('n', '<leader>sv', '<cmd>vsplit<Return>', { desc = 'Split Window Vertical', noremap = false })

util.set_keymap('n', '<leader>te', '<cmd>tabedit<Return>', 'Tab Edit')

util.set_keymap('n', '<leader>nh', '<cmd>nohlsearch<cr>', 'Clear Highlight Search')

-- diagnostic
---@param next boolean
---@param severity vim.diagnostic.Severity?
---@return function
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
util.set_keymap('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
util.set_keymap('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
util.set_keymap('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
util.set_keymap('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
util.set_keymap('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
util.set_keymap('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')

-- quickfix
util.set_keymap('n', '[q', vim.cmd.cprev, 'Prev Quickfix')
util.set_keymap('n', ']q', vim.cmd.cnext, 'Next Quickfix')

-- lazy
util.set_keymap('n', '<leader>l', '<cmd>Lazy<cr>', 'Lazy')

-- commenting
util.set_keymap('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', 'Add Comment Below')
util.set_keymap('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', 'Add Comment Above')

-- 在查找内容时, 总是使用`n`查找下一个, `N`查找上一个
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
util.set_keymap('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
util.set_keymap('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
util.set_keymap('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
util.set_keymap('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
util.set_keymap('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
util.set_keymap('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- 在normal模式下, 将当前行向上移或向下移; 支持数字前缀, 表示移动的行数, 比如'2<A-j>'.
util.set_keymap('n', '<A-j>', ":<c-u>execute 'move +'. v:count1<cr>", 'Move Line Down')
util.set_keymap('n', '<A-k>', ":<c-u>execute 'move -1-'. v:count1<cr>", 'Move Line Up')
-- 在insert模式下, 将当前行向上移或向下移
util.set_keymap('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Line Down (insert mode)' })
util.set_keymap('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Line Up (insert mode)' })
-- 在visual模式下, 将选中的行向上移或向下移
util.set_keymap(
  'v',
  '<A-j>',
  ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
  { desc = 'Move Selected Lines Down' }
)
util.set_keymap(
  'v',
  '<A-k>',
  ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
  { desc = 'Move Selected Lines Up' }
)

-- Terminal Mapping
util.set_keymap('t', '<ESC>', '<C-\\><C-n>', 'Exit Terminal Mode')
-- util.set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', 'Move to Left Window in Terminal Mode')
-- util.set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', 'Move to Down Window in Terminal Mode')
-- util.set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', 'Move to Up Window in Terminal Mode')
-- util.set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', 'Move to Right Window in Terminal Mode')

-- 自动将当前buffer的fileformat修改为dos
-- util.set_keymap('n', '<leader>df', function()
--   vim.bo.fileformat = 'dos'
--   vim.cmd('w')
--   vim.notify('FileFormat Set To DOS', vim.log.levels.INFO)
-- end, 'Set File Format to DOS')

if vim.g.neovide then
  -- 在neovide中, 使用CTRL+V来粘贴内容
  util.set_keymap('i', '<C-v>', '<C-r>+', 'Paste in Insert Mode for neovide')
end
