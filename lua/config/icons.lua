local M = {}

local defaults = {
  icons = {
    diagnostics = {
      Error = ' ',
      Warn = ' ',
      Hint = ' ',
      Info = ' ',
    },
    git = {
      added = ' ',
      modified = ' ',
      removed = ' ',
    },
    kinds = {
      Array = ' ',
      Boolean = '󰨙 ',
      Class = ' ',
      Codeium = '󰘦 ',
      Color = ' ',
      Control = ' ',
      Collapsed = ' ',
      Constant = '󰏿 ',
      Constructor = ' ',
      Copilot = ' ',
      Enum = ' ',
      EnumMember = ' ',
      Event = ' ',
      Field = ' ',
      File = ' ',
      Folder = ' ',
      Function = '󰊕 ',
      Interface = ' ',
      Key = ' ',
      Keyword = ' ',
      Method = '󰊕 ',
      Module = ' ',
      Namespace = '󰦮 ',
      Null = ' ',
      Number = '󰎠 ',
      Object = ' ',
      Operator = ' ',
      Package = ' ',
      Property = ' ',
      Reference = ' ',
      Snippet = '󱄽 ',
      String = ' ',
      Struct = '󰆼 ',
      Supermaven = ' ',
      TabNine = '󰏚 ',
      Text = ' ',
      TypeParameter = ' ',
      Unit = ' ',
      Value = ' ',
      Variable = '󰀫 ',
    },
    -- icons for lsp clients
    lsp_client_icon = {
      clangd = ' ',
      cssls = ' ',
      html = ' ',
      jsonls = ' ',
      -- lua_ls = ' ',
      lua_ls = 'lua',
      vtsls = ' ',
      vue_ls = ' ',
      zig = ' ',
      copilot = ' ',
    },
  },
}

-- 获取默认icons
function M.get_icons()
  return vim.tbl_deep_extend('force', {}, defaults.icons)
end

--- 获取lsp客户端图标
---@param name string lsp客户端名称
---@return string 图标
function M.get_icon_by_lsp_name(name)
  local icons = M.get_icons().lsp_client_icon
  return icons[name] -- 默认图标
end

return M
