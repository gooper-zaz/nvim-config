return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    event = 'BufReadPost',
    build = ':TSUpdate',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    keys = {
      { 'gnn', desc = 'Increment Selection' },
      { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
    opts_extend = { 'ensure_installed' },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        'vim',
        'vimdoc',
        'regex',
        'lua',
        'luadoc',
        'bash',
        'markdown',
        'markdown_inline',
        'html',
        'css',
        'json',
        'yaml',
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'gna',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufReadPost',
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPost' },
    config = function()
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = 'rainbow-delimiters.strategy.global',
          vim = 'rainbow-delimiters.strategy.local',
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          -- 这几种文件类型只处理括号对着色
          javascript = 'rainbow-parens',
          typescript = 'rainbow-parens',
          tsx = 'raibaow-parens',
          vue = 'rainbow-parens',
          html = 'rainbow-parens',
          css = 'rainbow-parens',
          scss = 'rainbow-parens',
        },
        highlight = {
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
          'RainbowDelimiterRed',
        },
        blacklist = {
          'markdown',
          'markdown_inline',
          'text',
          'txt',
          'help',
          'gitcommit',
          'gitrebase',
          'diff',
          'python',
        },
      })
    end,
  },
}
