return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'vue', 'css' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ---@type vim.lsp.Config
        vue_ls = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          settings = {
            vue = {
              server = {
                maxOldSpaceSize = 8192,
              },
            },
          },
          root_markers = {
            'tsconfig.json',
            'package.json',
            '.git/',
            'jsconfig.json',
            'vite.config.js',
            'vite.config.ts',
          },
        },
        vtsls = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local util = require('config.util')
      table.insert(opts.servers.vtsls.filetypes, 'vue')
      util.extend(opts.servers.vtsls, 'settings.vtsls.tsserver.globalPlugins', {
        {
          name = '@vue/typescript-plugin',
          location = util.get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
          languages = { 'vue' },
          configNamespace = 'typescript',
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        vue = { 'custom_prettier' },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'prettier',
        'prettierd',
      },
    },
  },
}
