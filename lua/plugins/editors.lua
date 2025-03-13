return {
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>td', '<cmd>Trouble diagnostics toggle<cr>', desc ='[t]rouble [d]iagnostics' }
    },
    opts = {}
  },
  {
    -- 使用'jk'退出insert mode
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
}
