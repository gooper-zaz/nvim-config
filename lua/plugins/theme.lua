return {
  {
    -- color theme
    -- 'sainnhe/everforest',
    "catppuccin/nvim",
    name = "catppuccin",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",
      "utilyre/barbecue.nvim",
    },
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
      })
      -- vim.g.everforest_diagnostic_line_highlight = 1
      -- vim.cmd('colorscheme everforest')
      vim.cmd("colorscheme catppuccin")
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          icons_enabled = true,
        },
      })
      require("barbecue").setup({
        theme = "catppuccin",
      })
    end,
  },
}
