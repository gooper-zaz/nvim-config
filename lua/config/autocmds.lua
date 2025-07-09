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

-- 复制文本时高亮内容
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = augroup('highlight_yank'),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- 创建一个自定义事件 'Laziest'，在 VeryLazy 事件触发时执行
-- 用于优化一些插件加载时机, 在不影响nvim启动时间的前提下, 提升nvim打开文件的速度
-- 通过给插件设置`evetns = 'User Laziest'`, 使插件在这个事件触发时加载
-- `BufReadPost` `BufNewFile` 能够优化nvim启动时间, 但是当过多插件依赖这几个事件后, 会明显拖慢buffer打开速度, 这种情况下可以考虑使用这个事件
-- inspired by [IceNvim](https://github.com/Shaobin-Jiang/IceNvim)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local function should_trigger()
      return vim.bo.filetype ~= 'dashboard' and vim.api.nvim_buf_get_name(0) ~= ''
    end

    local function trigger()
      vim.api.nvim_exec_autocmds('User', { pattern = 'Laziest' })
    end

    if should_trigger() then
      trigger()
      return
    end

    local lazy_load
    lazy_load = vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        if should_trigger() then
          trigger()
          vim.api.nvim_del_autocmd(lazy_load)
        end
      end,
    })
  end,
})

local max_size = 1024 * 1024 -- 1MB
local exclude_filetypes = { 'image', 'binary', 'media', 'pdf', 'zip', 'tar', 'gzip', 'bzip2', 'xz', '7z' }

-- 在特定条件下开启'cursorcolumn', 只在文件大小小于1MB, 且不是二进制文件时开启
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('cursorcolumn'),
  pattern = '*',
  callback = function(args)
    local stat = vim.uv.fs_stat(args.file)
    if not stat then
      return
    end
    local buf = args.buf
    local filetype = vim.bo[buf].filetype
    local file_size = stat.size

    -- 检查文件大小和文件类型
    if file_size > 0 and file_size < max_size and not vim.tbl_contains(exclude_filetypes, filetype) then
      vim.opt_local.cursorcolumn = true
    else
      vim.opt_local.cursorcolumn = false
    end
  end,
})
