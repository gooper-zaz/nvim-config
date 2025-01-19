return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'css-lsp',
        'html-lsp',
        'emmet-ls',
      })
      if opts.ui then
        opts.ui.border = 'rounded'
      else
        opts.ui = {
          border = 'rounded',
        }
      end
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
    init = function()
      -- 使用lspsaga来替换一部分功能
      local keys = require('lazyvim.plugins.lsp.keymaps').get()
      keys[#keys + 1] = { 'K', '<cmd>Lspsaga hover_doc<cr>' }
      keys[#keys + 1] = { '<leader>cr', '<cmd>Lspsaga rename<cr>' }
      keys[#keys + 1] = { '<leader>ol', '<cmd>Lspsaga outline<cr>' }
      keys[#keys + 1] = { '<leader>ca', '<cmd>Lspsaga code_action<cr>' }
    end,
    -- opts = {
    --   inlay_hints = { enabled = true },
    --   setup = {
    --     eslint = function()
    --       require('lazyvim.util').lsp.on_attach(function(client)
    --         if client.name == 'eslint' then
    --           client.server_capabilities.documentFormattingProvider = true
    --         elseif client.name == 'tsserver' then
    --           client.server_capabilities.documentFormattingProvider = false
    --         end
    --       end)
    --     end,
    --   },
    --   ---@type lspconfig.options
    --   servers = {
    --     eslint = {},
    --     lua_ls = {
    --       single_file_support = true,
    --       settings = {
    --         Lua = {
    --           workspace = { checkThirdParty = false },
    --           telemetry = { enable = false },
    --           diagnostics = {
    --             globals = { 'vim' },
    --           },
    --         },
    --       },
    --     },
    --     cssls = {
    --       settings = {},
    --     },
    --     emmet_ls = {
    --       filetypes = {
    --         'html',
    --         'typescriptreact',
    --         'javascriptreact',
    --         'css',
    --         'sass',
    --         'scss',
    --         'less',
    --         'markdown',
    --         'vue',
    --       },
    --       init_options = { -- better html/css snippets supported
    --         html = {
    --           options = {
    --             -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L26
    --             ['bem.enabled'] = true,
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
