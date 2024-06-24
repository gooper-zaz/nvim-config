-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- fold
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- opt.foldenable = false

opt.conceallevel = 0
opt.showtabline = 3
opt.laststatus = 3
vim.g.lazyvim_prettier_needs_config = true

-- neovide 配置
if vim.g.neovide then
  -- 轨道动画
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.o.guifont = 'JetBrainsMono Nerd Font Mono'
  -- 没有空闲
  vim.g.neovide_no_idle = true

  -- dynamic scale
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set('n', '<D-=>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<D-->', function()
    change_scale_factor(1 / 1.25)
  end)
end
