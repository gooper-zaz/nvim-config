return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, { 'css', 'vue', 'scss' })
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn', -- set to `false` to disable one of the mappings
          node_incremental = 'ni',
          scope_incremental = 'si',
          node_decremental = 'nd',
        },
      }
    end,
  },
  -- NOTE: use snacks
  -- {
  --   'hiphish/rainbow-delimiters.nvim',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   event = { 'BufReadPost' },
  --   config = function()
  --     local rainbow = require('rainbow-delimiters')
  --     require('rainbow-delimiters.setup').setup({
  --       strategy = {
  --         [''] = rainbow.strategy['global'],
  --         vim = rainbow.strategy['local'],
  --       },
  --       query = {
  --         [''] = 'rainbow-delimiters',
  --         lua = 'rainbow-blocks',
  --       },
  --       priority = {
  --         [''] = 110,
  --         lua = 210,
  --       },
  --       highlight = {
  --         'RainbowDelimiterRed',
  --         'RainbowDelimiterYellow',
  --         'RainbowDelimiterBlue',
  --         'RainbowDelimiterOrange',
  --         'RainbowDelimiterGreen',
  --         'RainbowDelimiterViolet',
  --         'RainbowDelimiterCyan',
  --       },
  --     })
  --   end,
  -- },
}
