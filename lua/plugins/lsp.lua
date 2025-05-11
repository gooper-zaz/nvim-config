return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    opts = function()
      local icons = require('config.icons')
      local diagnostic_icons = icons.get_icons()
      ---@class PluginLspOpts
      local ret = {
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spaces = 4,
            source = 'if_many',
            prefix = '●',
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = diagnostic_icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = diagnostic_icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = diagnostic_icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = diagnostic_icons.diagnostics.Info,
            },
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = { 'vue' },
        },
        codelens = {
          enabled = true,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
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
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {},
      }

      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local mlsp = require('mason-lspconfig')
      local blink = require('blink.cmp')
      local lspconfig = require('lspconfig')

      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function on_attach(client, buffer)
        local filetype = vim.api.nvim_buf_get_option(buffer, 'filetype')
        -- 只在 vue 文件中禁用 documentHighlight
        if filetype == 'vue' then
          if client.server_capabilities.documentHighlightProvider then
            client.server_capabilities.documentHighlightProvider = false
          end
        end

        -- 注册快捷键
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
          desc = 'Goto definition',
          noremap = true,
        })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {
          desc = 'References',
          noremap = true,
          buffer = buffer,
        })
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, {
          desc = 'Goto Implementation',
          noremap = true,
          buffer = buffer,
        })
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, {
          desc = 'Goto T[y]pe Definition',
          noremap = true,
          buffer = buffer,
        })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
          desc = 'Goto Declaration',
          noremap = true,
          buffer = buffer,
        })

        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover()
        end, {
          desc = 'Hover',
          noremap = true,
          buffer = buffer,
        })
        vim.keymap.set('i', '<c-k>', function()
          return vim.lsp.buf.signature_help()
        end, {
          desc = 'Signature help',
          noremap = true,
          buffer = buffer,
        })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
          desc = 'Code action',
          noremap = true,
          buffer = buffer,
        })
        vim.keymap.set('n', '<leader>cr', function()
          -- 如果当前filetype是'vue', 则使用vim内置的rename行为
          if vim.bo.filetype == 'vue' then
            return ':lua vim.lsp.buf.rename()<CR>'
          end
          local inc = require('inc_rename')
          return ':' .. inc.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
        end, { expr = true, buffer = buffer })
      end

      -- setup function
      ---@param server string
      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        end

        lspconfig[server].setup(server_opts)
      end

      local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings').get_all().lspconfig_to_package)

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      mlsp.setup({
        automatic_installation = true,
        automatic_enable = true,
        ensure_installed = ensure_installed,
        handlers = { setup },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_config_attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local buffer = event.buf
          return on_attach(client, buffer)
        end,
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function() end,
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
        'shfmt',
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
