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
        vue_ls = {
          -- filetypes = { 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
          init_options = {
            vue = {
              hybridMode = false,
            },
          },
          settings = {
            -- FIXME: seems not working
            vue = {
              server = {
                maxOldSpaceSize = 8192,
              },
              autoInsert = {
                bracketSpacing = true,
              },
              inlayHints = {
                desctructuredProps = true,
                inlineHandlerLeading = true,
              },
              suggest = {
                componentNameCasing = 'preferPascalCase',
                propNameCasing = 'preferKebabCase',
                defineAssignment = true,
              },
              format = {
                template = { initialIndent = true },
                style = { initialIndent = true },
                script = { initialIndent = true },
              },
            },
          },
          -- root_markers = {
          --   'tsconfig.json',
          --   'package.json',
          --   '.git/',
          --   'jsconfig.json',
          --   'vite.config.js',
          --   'vite.config.ts',
          -- },
          -- for vue_ls v3.0.0
          -- https://github.com/vuejs/language-tools/wiki/Neovim
          -- 在最新的nvim-lspconfig中, 已经内置了这段逻辑
          -- on_init = function(client)
          --   client.handlers['tsserver/request'] = function(_, result, context)
          --     local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
          --     if #clients == 0 then
          --       vim.notify(
          --         'Could not found `vtsls` lsp client, vue_lsp would not work without it.',
          --         vim.log.levels.ERROR
          --       )
          --       return
          --     end
          --     local ts_client = clients[1]
          --
          --     local param = unpack(result)
          --     local id, command, payload = unpack(param)
          --     ts_client:exec_cmd({
          --       title = 'vue_request_forward',
          --       command = 'typescript.tsserverRequest',
          --       arguments = {
          --         command,
          --         payload,
          --       },
          --     }, { bufnr = context.bufnr }, function(_, r)
          --       -- r may be nil
          --       local response_data = { { id, r and r.body } }
          --       ---@diagnostic disable-next-line: param-type-mismatch
          --       client:notify('tsserver/response', response_data)
          --     end)
          --   end
          -- end,
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
