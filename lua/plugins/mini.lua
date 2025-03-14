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
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      }
    },
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
