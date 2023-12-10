-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc', 'markdown' },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
--   callback = function()
--     local current_mode = vim.fn.mode()
--     if current_mode == 'n' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == 'v' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == 'V' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == '�' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == 'i' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     end
--   end,
-- })
