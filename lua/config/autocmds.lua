-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup('custom_' .. name, { clear = true })
end

-- 输入行注释时, 回车换行会自动在行首添加行注释前缀, 这里在lua文件里禁用这个功能
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('no_auto_comment_prefix'),
  pattern = 'lua',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})

-- 使光标回到上次退出时的位置
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_loc'),
  pattern = '*',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
