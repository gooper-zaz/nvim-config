return {
  {
    'neovim/nvim-lspconfig',
    -- event = { 'User Laziest', 'BufNewFile', 'BufReadPre' },
    event = { 'User Laziest', 'BufNewFile' },
    dependencies = {
      { 'saghen/blink.cmp' },
      { 'mason-org/mason-lspconfig.nvim' },
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
          float = {
            border = 'rounded',
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = { 'vue' },
        },
        codelens = {
          enabled = false,
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
        -- 这里的 setup 函数可以用来配置特定的 LSP 服务器
        -- 如果返回true, 你需要在setup中手动调用`vim.lsp.config`
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
      -- local lspconfig = require('lspconfig')
      local util = require('config.util')

      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      -- lsp on_attach callback
      ---@param client vim.lsp.Client
      ---@param buffer number
      local function on_attach(client, buffer)
        -- 使用lsp api检测是否支持'textDocument/documentHighlight'
        local buf = vim.bo[buffer]
        local is_vue = buf.filetype == 'vue'
        if not client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, buffer) or is_vue then
          client.server_capabilities.documentHighlightProvider = false
        end

        -- inlay hints
        if opts.inlay_hints.enabled and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          local is_excluded = vim.tbl_contains(opts.inlay_hints.exclude or {}, vim.bo[buffer].filetype)
          if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == '' and not is_excluded then
            vim.lsp.inlay_hint.enable(true, {
              bufnr = buffer,
            })
          end
        end
        -- code lens
        if opts.codelens.enabled and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end

        -- 注册快捷键
        util.set_keymap('n', 'gd', function()
          Snacks.picker.lsp_definitions()
        end, {
          desc = 'Goto Definition',
          buffer = buffer,
        })
        util.set_keymap('n', 'gD', function()
          Snacks.picker.lsp_declarations()
        end, {
          desc = 'Goto Declaration',
          buffer = buffer,
        })
        util.set_keymap('n', 'grr', function()
          Snacks.picker.lsp_references()
        end, {
          desc = 'References',
          buffer = buffer,
        })
        util.set_keymap('n', 'gI', function()
          Snacks.picker.lsp_implementations()
        end, {
          desc = 'Goto Implementation',
          buffer = buffer,
        })
        util.set_keymap('n', 'gy', function()
          Snacks.picker.lsp_type_definitions()
        end, {
          desc = 'Goto Type Definition',
          buffer = buffer,
        })
        util.set_keymap('n', 'K', function()
          vim.lsp.buf.hover()
        end, {
          desc = 'Hover',
          buffer = buffer,
        })
        -- hover diagnostic
        util.set_keymap('n', '<leader>hd', function()
          vim.diagnostic.open_float({
            source = true,
            bufnr = buffer,
          })
        end, {
          desc = 'Hover Diagnostic',
          buffer = buffer,
        })
        util.set_keymap('i', '<c-k>', function()
          return vim.lsp.buf.signature_help()
        end, {
          desc = 'Signature Help',
          buffer = buffer,
        })
        util.set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, {
          desc = 'Code Action',
          buffer = buffer,
        })
        util.set_keymap('n', '<leader>cc', vim.lsp.codelens.run, {
          desc = 'Code Lens',
          buffer = buffer,
        })
        util.set_keymap('n', '<leader>cr', function()
          local use_inc, inc = pcall(require, 'inc_rename')
          -- 如果当前filetype是'vue', 则使用vim内置的rename行为
          -- if use_inc ~= true or vim.bo.filetype == 'vue' then
          --   return ':lua vim.lsp.buf.rename()<CR>'
          -- end
          if not use_inc then
            return ':lua vim.lsp.buf.rename()<CR>'
          end
          return ':' .. inc.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
        end, { expr = true, buffer = buffer, desc = 'Code Rename' })
      end

      -- local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings').get_all().lspconfig_to_package)
      local exclude_automatic_enable = { 'stylua' } ---@type string[]

      -- setup function
      ---@param server string
      local function configure(server)
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

        vim.lsp.config(server, server_opts)

        -- vim.lsp.enable(server)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            configure(server)
            if server_opts.mason ~= false then
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      mlsp.setup({
        automatic_installation = true,
        automatic_enable = {
          enable = true,
          exclude = exclude_automatic_enable,
        },
        ensure_installed = ensure_installed,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp_config_attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            vim.notify(
              'LSP client not found for id: ' .. event.data.client_id,
              vim.log.levels.ERROR,
              { title = 'LSP Attach Error' }
            )
            return
          end
          local buffer = event.buf
          return on_attach(client, buffer)
        end,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
        end,
      })
    end,
  },
  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'User Laziest', 'BufNewFile' },
    config = function() end,
  },
  {
    'mason-org/mason.nvim',
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
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
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
    cmd = 'LazyDev',
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        -- 为`Snacks`全局变量加载类型声明
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },
}
