return {
  {
    'folke/noice.nvim',
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
      -- for vue
      opts.lsp.hover = {
        silent = true,
      }
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    opts = function(_, opts)
      local logo = [[
        
 ██████╗  ██████╗  ██████╗ ██████╗ ███████╗██████╗     ███████╗ ██████╗ ███╗   ██╗███████╗
██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔════╝██╔══██╗    ╚══███╔╝██╔═══██╗████╗  ██║██╔════╝
██║  ███╗██║   ██║██║   ██║██████╔╝█████╗  ██████╔╝      ███╔╝ ██║   ██║██╔██╗ ██║█████╗  
██║   ██║██║   ██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗     ███╔╝  ██║   ██║██║╚██╗██║██╔══╝  
╚██████╔╝╚██████╔╝╚██████╔╝██║     ███████╗██║  ██║    ███████╗╚██████╔╝██║ ╚████║███████╗
 ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝
                                                                                          
      ]]
      logo = string.rep('\n', 8) .. logo .. '\n\n'
      opts.config.header = vim.split(logo, '\n')
    end,
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
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPost' },
    cmd = { 'HighlightColors' },
    config = function()
      require('nvim-highlight-colors').setup({
        enabled_named_colors = false,
        render = 'virtual',
        virtual_symbol = '',
        virtual_symbol_position = 'inline',
        enable_tailwind = false,
      })
    end,
  },
  {
    -- 在行号旁边显示光标效果, 对快速移动有一点视觉上的辅助效果(比如20j, 30k之类的长距离移动)
    'gen740/SmoothCursor.nvim',
    event = { 'BufReadPost' },
    enabled = false,
    config = function()
      require('smoothcursor').setup({
        fancy = {
          enable = true,
        },
      })
    end,
  },
}
