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
    ---@type dropbar_configs_t
    opts = {
      menu = {
        keymaps = {
          ['Q'] = function()
            -- close all menus
            local utils = require('dropbar.utils')
            utils.menu.exec('close')
            utils.bar.exec('update_current_context_hl')
          end,
        },
        win_configs = {
          border = 'rounded',
        },
      },
    },
    config = function(_, opts)
      local util = require('config.util')
      local api = require('dropbar.api')
      util.set_keymap('n', '<leader>cp', api.pick, { desc = 'Context Pick (dropbar)' })
      util.set_keymap('n', '[;', api.goto_context_start, { desc = 'Go to Start of Current Context' })
      util.set_keymap('n', '];', api.select_next_context, { desc = 'Select Next Context' })
      require('dropbar').setup(opts)
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  -- 用来快速生成fucntion class type等文档注释
  -- 比如可以快速生成jsdoc/tsdoc
  {
    'danymat/neogen',
    cmd = 'Neogen',
    keys = {
      {
        '<leader>cn',
        function()
          require('neogen').generate()
        end,
        desc = 'Generate Annotations (Neogen)',
      },
    },
    opts = {},
  },
}
