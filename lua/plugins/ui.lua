return {
  {
    'folke/noice.nvim',
    opts = function(_, opts)
      opts.presets.lsp_doc_border = false
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
    config = function()
      require('colorizer').setup({
        user_default_options = {
          mode = 'foreground',
        },
      })
    end,
  },
}
