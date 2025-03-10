return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      -- transparent = true,
      styles = {
        sidebars = 'dark',
        floats = 'dark',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  }
}
