return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        ---@type vim.lsp.Config
        vtsls = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                  entriesLimit = 20,
                },
              },
              tsserver = {
                globalPlugins = {},
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                -- enbaled = true,
                -- autoImports = true,
                -- completeJSDocs = true,
                completeFunctionCalls = false, -- just want function name without params while completing
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              preferences = {
                quoteStyle = 'single',
                -- includePackageJsonAutoImports = 'off',
              },
              tsserver = {
                maxTsServerMemory = 8192, -- 8GB for large projects
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                -- enbaled = true,
                -- autoImports = true,
                -- completeJSDocs = true,
                completeFunctionCalls = false, -- just want function name without params while completing
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
              preferences = {
                quoteStyle = 'single',
                -- includePackageJsonAutoImports = 'off',
              },
              tsserver = {
                maxTsServerMemory = 8192, -- 8GB for large projects
              },
            },
          },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
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
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'javascript',
        'typescript',
        'tsx',
        'jsdoc',
        'html',
        'css',
        'scss',
      },
    },
  },
}
