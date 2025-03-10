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

-- 向左缩进
keymap.set('v', '<', '<gv', opts)
-- 向右缩进
keymap.set('v', '>', '>gv', opts)

keymap.set('n', 'H', '^', opts)
keymap.set('n', 'L', '$', opts)

-- Split window
keymap.set('n', 'ss', ':split<Return>', opts)
keymap.set('n', 'sv', ':vsplit<Return>', opts)

keymap.set('n', 'te', ':tabedit<Return>', opts)
keymap.set('n', '<tab>', ':tabnext<Return>', opts)
keymap.set('n', '<s-tab>', ':tabprev<Return>', opts)
