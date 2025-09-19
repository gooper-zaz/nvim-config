---@diagnostic disable: missing-fields
---@type LazySpec[]
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
    enabled = true,
    name = 'catppuccin',
    ---@type CatppuccinOptions
    opts = {
      flavour = 'mocha', -- 选择配色：mocha/latte/frappe/macchiato
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
      },
      styles = {
        comments = { 'altfont' },
        conditionals = { 'altfont' },
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
      color_overrides = {
        mocha = {
          base = '#0f0f1a', -- 更深的主背景
          mantle = '#0b0b11', -- 更深次级背景
          crust = '#000000', -- 极深背景
        },
      },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = '#2e2e46' }, -- 更显眼的光标行背景
          Cursor = { fg = '#cdd6f4', bg = '#f38ba8' }, -- 光标颜色
          Comment = { fg = '#7f8caa' }, -- 提亮后的注释
          TSComment = { fg = '#7f8caa' },
          Normal = { fg = colors.text, bg = '#000000' }, -- 全局正常背景
          LineNr = { fg = '#9ca0b0' },
          CursorLineNr = { fg = colors.yellow, style = { 'bold' } },
          GitSignsCurrentLineBlame = { fg = '#7f8caa' },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      -- 修改lazy.nvim的`LazyButtonActive`的颜色
      -- vim.api.nvim_set_hl(0, 'LazyButtonActive', { fg = '#ffffff', bg = '#f38ba8', bold = true })
      vim.api.nvim_set_hl(0, 'LazyButtonActive', { link = '@comment.hint' })
      vim.cmd([[colorscheme catppuccin-mocha]])
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
    enabled = false,
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
