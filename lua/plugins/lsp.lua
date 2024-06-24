return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- 'stylua',
        'css-lsp',
        -- 'vue-language-server',
        'html-lsp',
        -- 'typescript-language-server',
        -- 'json-lsp',
        -- 'eslint-lsp',
        -- 'eslint_d',
        -- 'prettier',
        -- 'prettierd',
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
    -- init = function()
    --   -- 使用lspsaga来替换一部分功能
    --   local keys = require('lazyvim.plugins.lsp.keymaps').get()
    --   -- keys[#keys + 1] = { 'K', '<cmd>Lspsaga hover_doc<cr>' }
    --   keys[#keys + 1] = { '<leader>cr', '<cmd>Lspsaga rename<cr>' }
    --   keys[#keys + 1] = { '<leader>ol', '<cmd>Lspsaga outline<cr>' }
    --   keys[#keys + 1] = { '<leader>ca', '<cmd>Lspsaga code_action<cr>' }
    -- end,
    opts = {
      inlay_hints = { enabled = true },
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
        cssls = {
          settings = {},
        },
      },
    },
  },
}
