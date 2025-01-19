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
    -- @type snacks.Config
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
}
