return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
      { '<leader>fr', '<cmd>Telescope resume<cr>' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>' },
      { '<leader>fv', '<cmd>Telescope vim_options<cr>' },
    },
    opts = function()
      local action = require('telescope.actions')
      return {
        defaults = {
          selection_caret = " ",
          theme = 'dropdown',
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
          file_ignore_patterns = { '.git', 'node_modules' },
          mapping = {
            n = {
              ['q'] = action.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true }
        },
      }
    end,
    config = function(_, opts)
      local t = require('telescope')
      t.setup(opts)
    end
  }
}
