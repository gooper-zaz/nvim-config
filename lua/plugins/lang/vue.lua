---@param pkg string 包名
---@param path string 包下的路径
local function get_pkg_path(pkg, path)
  pcall(require, 'mason')
  local root = vim.fn.stdpath('data') .. '/mason/packages/'

  return root .. pkg .. path
end
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
                maxOldSpaceSize = 8092,
              },
            },
          },
        },
        -- vtsls = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, 'vue')
      table.insert(opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins, {
        name = '@vue/typescript-plugin',
        location = get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
        languages = { 'vue' },
        configNamespace = 'typescript',
        enableForWorkspaceTypeScriptVersions = true,
      })
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
}
