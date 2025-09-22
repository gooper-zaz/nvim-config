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
        vue_ls = {},
        vtsls = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      local util = require('config.util')
      table.insert(opts.servers.vtsls.filetypes, 'vue')
      local location = util.get_pkg_path('vue-language-server', '/node_modules/@vue/language-server')
      util.extend(opts.servers.vtsls, 'settings.vtsls.tsserver.globalPlugins', {
        {
          name = '@vue/typescript-plugin',
          location = location,
          languages = { 'vue' },
          configNamespace = 'typescript',
          enableForWorkspaceTypeScriptVersions = true,
        },
      })
      return opts
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        vue = { 'prettier' },
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
}
