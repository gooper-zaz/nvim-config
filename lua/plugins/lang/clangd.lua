return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'cpp' } },
  },
  {
    'p00f/clangd_extensions.nvim',
    lazy = true,
    config = function() end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ---@type vim.lsp.Config
        clangd = {
          mason = false, -- 不使用mason安装, 使用系统安装的clangd
          -- enabled = false,
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          capabilities = {
            offsetEncoding = { 'utf-16' },
          },
        },
      },
      setup = {
        clangd = function(server, opts)
          local clangd_ext = require('clangd_extensions')
          local options = vim.tbl_deep_extend('force', {
            inlay_hints = {
              inline = false,
            },
            ast = {
              --These require codicons (https://github.com/microsoft/vscode-codicons)
              role_icons = {
                type = '',
                declaration = '',
                expression = '',
                specifier = '',
                statement = '',
                ['template argument'] = '',
              },
              kind_icons = {
                Compound = '',
                Recovery = '',
                TranslationUnit = '',
                PackExpansion = '',
                TemplateTypeParm = '',
                TemplateTemplateParm = '',
                TemplateParamObject = '',
              },
            },
            memory_usage = {
              border = 'rounded',
            },
            symbol_info = {
              border = 'rounded',
            },
          }, { server = opts })
          clangd_ext.setup(options)

          vim.lsp.config(server, opts)
          vim.lsp.enable(server)
          return true
        end,
      },
    },
  },
}
