---@diagnostic disable: missing-fields
return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    enabled = false,
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
    enabled = false,
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
    enabled = false,
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
        -- Diagnostic 相关（灰色未使用警告）
        vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = '#5c6779', italic = true })
        -- LSP Typemod unused 高亮
        vim.api.nvim_set_hl(0, '@lsp.typemod.variable.unused', { fg = '#5c6779', italic = true })
        vim.api.nvim_set_hl(0, '@lsp.typemod.parameter.unused', { fg = '#5c6779', italic = true })
        vim.api.nvim_set_hl(0, '@lsp.typemod.function.unused', { fg = '#5c6779', italic = true })
      end,
    },
    config = function(_, opts)
      -- require('nordic').load(opts)
      -- vim.cmd([[colorscheme nordic]])
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    enabled = false,
    ---@type KanagawaConfig
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
      overrides = function(colors)
        return {
          -- 修改 BufferLine Seperator颜色, 让它更显眼一些
          BufferLineIndicatorSelected = { fg = colors.fujiWhite, bg = 'NONE', bold = true },
        }
      end,
    },
    config = function(_, opts)
      -- require('kanagawa').setup(opts)
      -- vim.cmd([[colorscheme kanagawa]])
    end,
  },
  {
    'miikanissi/modus-themes.nvim',
    priority = 1000,
    config = function()
      require('modus-themes').setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_highlights = function(highlights, color)
          highlights.Boolean = { fg = color.green, bold = true }
          highlights.String = { fg = color.green_faint }
          highlights.Character = { fg = color.green_faint }
          local funcStyle = highlights.Function.style
          highlights.Function = { fg = color.yellow_faint, style = funcStyle }
        end,
      })
      vim.cmd([[colorscheme modus]])
      -- vim.cmd([[coloerscheme modus_vivendi]])
      -- vim.cmd([[coloerscheme modus_operandi]])
    end,
  },
}
