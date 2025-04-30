-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set('i', '<A-j>', '<Down>') -- 在insert模式向下移动光标
keymap.set('i', '<A-k>', '<Up>') -- 在insert模式向上移动光标
keymap.set('i', '<A-h>', '<Left>') -- 在insert模式向左移动光标
keymap.set('i', '<A-l>', '<Right>') -- 在insert模式向右移动光标
keymap.set('i', '<C-u>', '<C-G>u<C-U>')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G', opts)
-- Save
keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', opts)
-- Quit
keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit All' })

-- 向左缩进
keymap.set('v', '<', '<gv', opts)
-- 向右缩进
keymap.set('v', '>', '>gv', opts)

keymap.set('n', 'H', '^', opts)
keymap.set('n', 'L', '$', opts)

-- Split window
keymap.set('n', 'ss', ':split<Return>', opts)
keymap.set('n', 'sv', ':vsplit<Return>', opts)

-- quickfix
keymap.set('n', '[q', vim.cmd.cprev, opts)
keymap.set('n', ']q', vim.cmd.cnext, opts)

-- code action
keymap.set('n', '<leader>ca', function()
  return vim.lsp.buf.code_action()
end, opts)
-- lsp rename(see noice.lua)
-- keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)

keymap.set('n', 'te', ':tabedit<Return>', opts)
keymap.set('n', '<tab>', ':tabnext<Return>', opts)
keymap.set('n', '<s-tab>', ':tabprev<Return>', opts)

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- lazy
keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- commenting
keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- 在查找内容时, 总是使用`n`查找下一个, `N`查找上一个
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- 在normal模式下, 将当前行向上移或向下移; 支持数字前缀, 表示移动的行数, 比如'2[a'.
keymap.set(
  'n',
  '[a',
  ":<c-u>execute 'move -1-'. v:count1<cr>",
  { desc = 'Move current line above', noremap = true, silent = true }
)
keymap.set(
  'n',
  ']a',
  ":<c-u>execute 'move +'. v:count1<cr>",
  { desc = 'Move current line below', noremap = true, silent = true }
)
