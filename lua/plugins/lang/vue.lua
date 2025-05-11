return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'vue', 'css' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        volar = {
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
