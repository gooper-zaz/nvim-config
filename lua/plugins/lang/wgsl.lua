return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        wgsl_analyzer = {
          settings = {
            wgsl_analyzer = {
              diagnostics = {
                enable = true,
              },
              inlayHints = {
                enabled = true, -- 在 shader 中显示内联参数类型
              },
            },
          },
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'wgsl' } },
  },
}
