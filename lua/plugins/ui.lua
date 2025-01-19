return {
  {
    'folke/noice.nvim',
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        hover = {
          silent = true,
        },
      },
    },
  },
  {
    'folke/snacks.nvim',
    --- @type snacks.Config
    opts = {
      dashboard = {
        preset = {
          header = [[

          ██████╗  ██████╗  ██████╗ ██████╗ ███████╗██████╗     ███████╗ ██████╗ ███╗   ██╗███████╗
          ██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗    ╚══███╔╝██╔═══██╗████╗  ██║██╔════╝
          ██║  ███╗██║   ██║██║   ██║██████╔╝█████╗  ██████╔╝      ███╔╝ ██║   ██║██╔██╗ ██║█████╗  
          ██║   ██║██║   ██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗     ███╔╝  ██║   ██║██║╚██╗██║██╔══╝  
          ╚██████╔╝╚██████╔╝╚██████╔╝██║     ███████╗██║  ██║    ███████╗╚██████╔╝██║ ╚████║███████╗
          ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

        ]],
        },
      },
      scroll = { enabled = false },
      indent = {
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = '│',
          underline = false, -- underline the start of the scope
          only_current = true, -- only show scope in the current window
          -- hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
          hl = {
            'RainbowRed',
            'RainbowYellow',
            'RainbowBlue',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
          },
        },
      },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPost' },
    -- NOTE: disable `nvim-colorizer`
    enabled = false,
    config = function()
      require('colorizer').setup({
        user_default_options = {
          mode = 'virtualtext',
        },
      })
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    event = { 'BufReadPost' },
    config = function()
      local rainbow = require('rainbow-delimiters')
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = rainbow.strategy['global'],
          vim = rainbow.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      })
    end,
  },
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = {
      term_colors = true,
      custom_highlights = function()
        return {
          RainbowRed = { fg = '#E06C75' },
          RainbowYellow = { fg = '#E5C07B' },
          RainbowBlue = { fg = '#61AFEF' },
          RainbowOrange = { fg = '#D19A66' },
          RainbowGreen = { fg = '#98C379' },
          RainbowViolet = { fg = '#C678DD' },
          RainbowCyan = { fg = '#56B6C2' },
        }
      end,
    },
  },
}
