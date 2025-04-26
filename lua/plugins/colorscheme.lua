return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      -- transparent = true,
      styles = {
        sidebars = 'dark',
        floats = 'dark',
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      -- vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    name = 'catppuccin',
    ---@type CatppuccinOptions
    opts = {
      flavour = 'macchiato', -- 选择配色：mocha/latte/frappe/macchiato
      integrations = {
        blink_cmp = true,
        telescope = true, -- 适配 Telescope 插件
        treesitter = true, -- 适配 Treesitter
        mason = true, -- 适配 Mason
        notify = true,
        gitsigns = true,
        snacks = true,
        noice = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        navic = { enabled = true, custom_bg = 'lualine' },
      },
      styles = {
        comments = { 'altfont' },
      },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
