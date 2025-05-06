return {
  {
    'windwp/nvim-ts-autotag',
    event = 'BufReadPost',
    opts = {},
  },
  {
    'folke/ts-comments.nvim',
    event = 'BufReadPost',
    opts = {},
  },
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>td', '<cmd>Trouble diagnostics toggle<cr>', desc = '[t]rouble [d]iagnostics' },
    },
    opts = {},
  },
  {
    -- 使用'jk'退出insert mode
    'max397574/better-escape.nvim',
    event = 'VeryLazy',
    opts = {
      mappings = {
        i = {
          j = {
            k = '<Esc>',
            j = false, -- disable 'jj'
          },
        },
      },
    },
    config = function(_, opts)
      require('better_escape').setup(opts)
    end,
  },
  -- 在bufferline下边显示面包屑状态栏, 包含当前文件路径, 当前所在符号等
  {
    'Bekaboo/dropbar.nvim',
    event = 'BufReadPost',
    opts = {},
    -- config = function(_, opts)
    --   local dropbar_api = require('dropbar.api')
    --   vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
    --   vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
    --   vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    -- end
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
