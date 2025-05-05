return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'html', 'css' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        html = {},
        cssls = {},
      },
    },
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'prettierd',
      },
    },
  },
}
