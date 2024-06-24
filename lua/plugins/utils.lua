return {
  {
    -- 使用'jk'退出insert mode
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  -- {
  --   'lewis6991/gitsigns.nvim',
  --   keys = {
  --     { '<leader>gb', mode = { 'n' }, '<Cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'current line [G]it [B]lame' },
  --   },
  -- },
}
