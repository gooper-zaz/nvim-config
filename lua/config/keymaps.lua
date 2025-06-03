-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local util = require('config.util')

util.set_keymap('i', '<A-j>', '<Down>', 'Move Cursor Down in insert mode') -- 在insert模式向下移动光标
util.set_keymap('i', '<A-k>', '<Up>', 'Move Cursor Up in insert mode') -- 在insert模式向上移动光标
util.set_keymap('i', '<A-h>', '<Left>', 'Move Cursor Left in insert mode') -- 在insert模式向左移动光标
util.set_keymap('i', '<A-l>', '<Right>', 'Move Cursor Right in insert mode') -- 在insert模式向右移动光标
util.set_keymap('i', '<C-u>', '<C-G>u<C-U>', '<C-G>u<C-U>')

-- Select all
util.set_keymap('n', '<C-a>', 'gg<S-v>G', 'Select All')
-- Save
util.set_keymap({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', 'Save')
-- Quit
util.set_keymap('n', '<leader>qq', '<cmd>qa<CR>', 'Quit All')

-- 向左缩进
util.set_keymap('v', '<', '<gv', 'Indent Left')
-- 向右缩进
util.set_keymap('v', '>', '>gv', 'Indent Right')

util.set_keymap({ 'n', 'v', 'o' }, 'H', '^', 'Start Of Line')
util.set_keymap({ 'n', 'v', 'o' }, 'L', '$', 'End Of Line')

-- Split window
util.set_keymap('n', 'ss', ':split<Return>', { desc = 'Split Window', noremap = false })
util.set_keymap('n', 'sv', ':vsplit<Return>', { desc = 'Split Window Vertical', noremap = false })

-- quickfix
util.set_keymap('n', '[q', vim.cmd.cprev, 'Prev Quickfix')
util.set_keymap('n', ']q', vim.cmd.cnext, 'Next Quickfix')

util.set_keymap('n', '<leader>te', ':tabedit<Return>', 'Tab Edit')
util.set_keymap('n', '<tab>', ':tabnext<Return>', 'Next Tab')
util.set_keymap('n', '<s-tab>', ':tabprev<Return>', 'Prev Tab')

-- diagnostic
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

-- 在normal模式下, 将当前行向上移或向下移; 支持数字前缀, 表示移动的行数, 比如'2[m'.
util.set_keymap('n', '[m', ":<c-u>execute 'move -1-'. v:count1<cr>", 'Move current line above')
util.set_keymap('n', ']m', ":<c-u>execute 'move +'. v:count1<cr>", 'Move current line below')
