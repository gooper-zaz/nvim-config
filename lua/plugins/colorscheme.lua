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
      -- require('tokyonight').setup(opts)
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
      -- require('catppuccin').setup(opts)
      -- vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    ---@type NordicOptions
    opts = {
      italic = false,
      bright_border = true,
      telescope = {
        style = 'classic',
      },
      cursorline = {
        theme = 'dark',
        bold_number = true,
      },
      after_palette = function(palette)
        local U = require('nordic.utils')
        palette.bg_visual = U.blend(palette.green.base, palette.bg, 0.15)
      end,
      on_highlight = function(hl, c)
        local U = require('nordic.utils')
        hl.CursorLineNr = { fg = c.green.base, bold = true }
        -- 加强一点行号的颜色, 默认的颜色有点看不清~
        hl.LineNr = { fg = U.blend(c.white0_normal, c.bg, 0.50), bold = false }
      end,
    },
    config = function(_, opts)
      require('nordic').load(opts)
      vim.cmd([[colorscheme nordic]])
    end,
  },
}
