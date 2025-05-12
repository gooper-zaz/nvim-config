return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        glsl_analyzer = {},
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'glsl' } },
  },
}
