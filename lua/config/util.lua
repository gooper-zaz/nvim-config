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
  local opt = { noremap = true, silent = true }
  if type(desc_or_opt) == 'string' then
    opt.desc = desc_or_opt
  elseif type(desc_or_opt) == 'table' then
    opt = vim.tbl_deep_extend('force', opt, desc_or_opt)
  end
  vim.keymap.set(mode, lhs, rhs, opt)
end

return M
