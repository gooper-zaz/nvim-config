-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 输入行注释时, 回车换行会自动在行首添加行注释前缀, 这里在lua文件里禁用这个功能
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})
