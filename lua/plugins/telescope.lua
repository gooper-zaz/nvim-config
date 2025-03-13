return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[f]ind [f]iles' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[f]ile [g]rep' },
      { '<leader>fr', '<cmd>Telescope resume<cr>', desc = '[f]ile [r]esume' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = '[f]ind [d]iagnostisc' },
      { '<leader>fv', '<cmd>Telescope vim_options<cr>', desc = '[f]ind [v]im opts' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = '[f]ind [b]uffers' },
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
