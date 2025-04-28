return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'glsl' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        glslls = {},
      },
    },
  },
}
