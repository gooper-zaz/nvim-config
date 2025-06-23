return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'zig' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        zls = {
          mason = false, -- 不使用mason安装, 使用系统安装的zls
          settings = {
            zls = {
              -- Whether to enable build-on-save diagnostics
              --
              -- Further information about build-on save:
              -- https://zigtools.org/zls/guides/build-on-save/
              -- enable_build_on_save = true,

              -- Neovim already provides basic syntax highlighting
              semantic_tokens = 'partial',

              -- omit the following line if `zig` is in your PATH
              -- zig_exe_path = '/path/to/zig_executable',
            },
          },
        },
      },
      setup = {
        zls = function(server, opts)
          vim.lsp.config(server, opts)
          vim.lsp.enable(server)

          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('zls_fix_all', { clear = true }),
            pattern = { '*.zig', '*.zon' },
            callback = function()
              vim.lsp.buf.code_action({
                context = { only = { 'source.fixAll' }, diagnostics = {} },
                apply = true,
              })
            end,
          })

          return true
        end,
      },
    },
  },
}
