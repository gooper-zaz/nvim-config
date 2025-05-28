local M = {}

--- This extends a deeply nested list with a key in a table
--- that is a dot-separated string.
--- The nested list will be created if it does not exist.
---@generic T
---@param t T[]
---@param key string
---@param values T[]
---@return T[]?
function M.extend(t, key, values)
  local keys = vim.split(key, '.', { plain = true })
  for i = 1, #keys do
    local k = keys[i]
    t[k] = t[k] or {}
    if type(t) ~= 'table' then
      return
    end
    t = t[k]
  end
  return vim.list_extend(t, values)
end

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
function M.get_pkg_path(pkg, path)
  pcall(require, 'mason') -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
  path = path or ''
  local ret = root .. '/packages/' .. pkg .. path
  return ret
end

-- set custom keymaps
---@param mode string|string[] vim mode
---@param lhs string lhs
---@param rhs string|function rhs
---@param desc_or_opt? string|vim.keymap.set.Opts keymap desc or keymap opt
function M.set_keymap(mode, lhs, rhs, desc_or_opt)
  ---@type vim.keymap.set.Opts
  local opt = { noremap = true, silent = true }
  if type(desc_or_opt) == 'string' then
    opt.desc = desc_or_opt
  elseif type(desc_or_opt) == 'table' then
    opt = vim.tbl_deep_extend('force', opt, desc_or_opt)
  end
  vim.keymap.set(mode, lhs, rhs, opt)
end

-- 搜索关键词
---@param word string 关键词
---@param pattern string|nil 搜索模式, 传入文件路径或文件匹配规则, `nil`时默认在当前buffer搜索
function M.search_keyword(word, pattern)
  local p = pattern or vim.fn.expand('%:p')
  local has_rg = vim.fn.executable('rg') == 1
  local has_grep = vim.fn.executable('grep') == 1

  if has_rg then
    -- 使用 ripgrep 搜索
    vim.cmd('silent! execute "!" . "rg --vimgrep --color=always ' .. word .. ' ' .. p .. '"')
  elseif has_grep then
    -- 使用 grep 搜索
    vim.cmd('silent! execute "!" . "grep -n --color=always ' .. word .. ' ' .. p .. '"')
  else
    -- 如果没有可用的搜索工具，使用vimgrep
    vim.cmd('silent! vimgrep /' .. word .. '/ ' .. p)
  end

  -- 打开 quickfix 窗口
  vim.cmd('copen')
end

return M
