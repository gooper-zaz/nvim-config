-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- neovide 配置
if vim.g.neovide then
  -- 轨道动画
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.o.guifont = "JetBrainsMono Nerd Font Mono"
  -- 没有空闲
  vim.g.neovide_no_idle = true
end
