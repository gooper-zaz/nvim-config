-- 输入行注释时, 回车换行会自动在行首添加行注释前缀, 这里在lua文件里禁用这个功能
vim.opt_local.formatoptions:remove({ 'r', 'o' })
