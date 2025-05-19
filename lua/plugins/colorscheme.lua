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
        theme = 'light',
      },
    },
    config = function(_, opts)
      require('nordic').load(opts)
      vim.cmd([[colorscheme nordic]])

      -- 等待主题加载完后再修改高亮组
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'nordic',
        callback = function()
          -- 获取 nordic 提供的颜色表
          local colors = require('nordic.colors')

          -- 设置普通行号颜色为灰色（如 comment 色）
          vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.blue2 })

          -- 设置当前行号颜色为主色调之一（如 nord_blue 或 yellow）
          vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.yellow.base, bold = true })
        end,
      })
    end,
  },
}
