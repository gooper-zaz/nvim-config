return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = 'Replace',
              },
              doc = {
                privateName = { '^_' },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
            },
          },
        },
      },
      setup = {},
    },
    config = function(_, opts)
      local servers = opts.servers

      local lsp = require('lspconfig')
      local mlsp = require('mason-lspconfig')
      local blink = require('blink.cmp')

      local capabilities = blink.get_lsp_capabilities()
      -- local all_mlsp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)

      -- setup keymaps
      local keymaps = {
        { key = 'gd', cmd = '<cmd>Telescope lsp_definitions<cr>' },
        {
          key = 'K',
          cmd = '<cmd>lua vim.lsp.buf.hover({max_width = math.floor(vim.o.columns * 0.7)})<cr>',
        },
        { key = 'gr', cmd = '<cmd>Telescope lsp_references<cr>' },
        -- { key = "[e", cmd = "<cmd>lua vim.diagnostic.goto_prev()<cr>" },
        -- { key = "]e", cmd = "<cmd>lua vim.diagnostic.goto_next()<cr>" },
      }
      local function setup_keymaps(bufnr)
        for _, map in ipairs(keymaps) do
          vim.api.nvim_buf_set_keymap(bufnr, 'n', map.key, map.cmd, { noremap = true, silent = true })
        end
      end

      local ensure_installed = {}
      for server, _ in pairs(servers) do
        -- if vim.tbl_contains(all_mlsp_servers, server) then
        ensure_installed[#ensure_installed + 1] = server
        -- end
      end

      local setup = function(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
          on_attach = function(client, buffer)
            local filetype = vim.api.nvim_buf_get_option(buffer, 'filetype')

            -- 只在 vue 文件中禁用 documentHighlight
            if filetype == 'vue' then
              if client.server_capabilities.documentHighlightProvider then
                client.server_capabilities.documentHighlightProvider = false
              end
            end
            setup_keymaps(buffer)
          end,
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server_opts) then
            return
          end
        end

        lsp[server].setup(server_opts)
      end

      mlsp.setup({
        automatic_installation = true,
        ensure_installed = ensure_installed,
        handlers = { setup },
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {},
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonUninstall', 'MasonLog', 'MasonUninstallAll' },
    keys = {
      { '<leader>m', '<cmd>Mason<cr>', desc = 'Mason' },
    },
    ---@type MasonSettings
    opts = {
      ensure_installed = {
        'stylua',
      },
      ui = {
        border = 'rounded',
        width = 0.8,
        height = 0.8,
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      local mr = require('mason-registry')

      mr:on('package.install:success', function()
        vim.defer_fn(function()
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
