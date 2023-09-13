vim.g.mapleader = " " -- space as leader key
local keymap = vim.keymap

-- ---------- 插入模式(insert) ---------- ---
keymap.set("i", "jk", "<ESC>") -- 在insert模式下快速连续按下jk, 可以退出insert模式
keymap.set("i", "<A-j>", "<Down>") -- 在insert模式向下移动光标
keymap.set("i", "<A-k>", "<Up>") -- 在insert模式向上移动光标
keymap.set("i", "<A-h>", "<Left>") -- 在insert模式向左移动光标
keymap.set("i", "<A-l>", "<Right>") -- 在insert模式向右移动光标
keymap.set("i", "<C-s>", "<Esc>:w<CR>")
keymap.set("i", "<C-u>", "<C-G>u<C-U>")

-- ---------- 视觉模式(visual) ----------
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "<", "<gv", { silent = true })
keymap.set("v", ">", ">gv", { silent = true })
-- WARN: 下面的这行配置在visual模式下会拖慢j键的响应速度
-- keymap.set("v", "jk", "<ESC>")
--
-- ---------- 正常模式(normal) ---------- ---
-- 退出
keymap.set("n", "<leader>q", "<cmd>q<cr>")
-- 强制退出
keymap.set("n", "<leader>qf", "<cmd>q!<cr>")
-- 保存
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>x", "<cmd>x<cr>")
-- 选中所有文本: 跳转到顶部(gg), 进入visual line(S-v), 跳转到底部(G), 选中所有
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "<leader>s", ":vsplit<Return><C-w>w", { silent = true })
-- keymap.set("n", "f", "<C-w>w")
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
-- 取消高亮
keymap.set("n", "<leader>nl", "<cmd>nohl<CR>")

-- buffer
keymap.set("n", "<S-L>", "<cmd>bnext<CR>") -- 下一个buffer
keymap.set("n", "<S-H>", "<cmd>bprevious<CR>") -- 上一个buffer
keymap.set("n", "<leader>bc", "<cmd>bd<CR>") -- 关闭当前buffer
-- ---------- 插件 ---------- ---
