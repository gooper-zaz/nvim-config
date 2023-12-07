return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, { 'css' })
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn', -- set to `false` to disable one of the mappings
          node_incremental = 'ni',
          scope_incremental = 'si',
          node_decremental = 'nd',
        },
      }
    end,
  },
}
