return {
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
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'prettier',
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        html = { 'prettier' },
        css = { 'prettier' },
      },
    },
  },
}
