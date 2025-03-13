return {
  {
    'echasnovski/mini.pairs',
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    opts = {},
  },
  {
    'echasnovski/mini.surround',
    opts = {},
  },
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPost',
    opts = {},
  },
  {
    'echasnovski/mini.files',
    keys = {
      { '<leader>e', ':lua MiniFiles.open()<cr>', desc = 'Open Dir/File with mini.files' }
    },
    opts = {},
    config = function(_, opts)
      require('mini.files').setup(opts)
    end
  },
}
