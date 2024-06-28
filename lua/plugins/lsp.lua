return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'css-lsp',
        'html-lsp',
        'emmet-ls',
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'Mason', 'Neoconf' },
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim', -- 这个相当于mason.nvim和lspconfig的桥梁
      'nvimdev/lspsaga.nvim',
    },
    opts = {
      inlay_hints = { enabled = true },
      -- Enable lsp cursor word highlighting
      document_highlight = {
        enabled = true,
      },
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
        -- cssls = {
        --   settings = {},
        -- },
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
          settings = {
            vue = {
              updateImportsOnFileMove = { enabled = true },
            },
          },
        },
      },
    },
  },
}
