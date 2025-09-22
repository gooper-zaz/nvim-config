return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'json5' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ---@type vim.lsp.Config
        jsonls = {
          before_init = function(_, config)
            config.settings.json.schemas = config.settings.json.schemas or {}
            vim.list_extend(config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        json = { 'prettier', 'jq', stop_after_first = true },
      },
    },
  },
}
