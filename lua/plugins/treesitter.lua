return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    event = 'VeryLazy',
    build = ':TSUpdate',
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
}
