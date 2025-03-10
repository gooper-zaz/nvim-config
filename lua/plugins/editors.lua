return {
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>td', '<cmd>Trouble diagnostics toggle<cr>'}
    },
    opts = {}
  }
}
