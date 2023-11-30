return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "css-lsp",
        "vue-language-server",
        "html-lsp",
        -- "typescript-language-server",
        "json-lsp",
        "eslint-lsp",
        "eslint_d",
        "prettier",
        "prettierd",
        "emmet-ls",
      })
    end,
  },
  {
    "b0o/schemastore.nvim",
    -- dependencies = {
    --   "folke/neodev.nvim",
    -- },
    opts = {},
    ft = { "json", "jsonc" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- require("neodev").setup()
      require("lspconfig").jsonls.setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "Mason", "Neoconf" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
      -- "jose-elias-alvarez/typescript.nvim",
      "b0o/schemastore.nvim",
    },
    opts = {
      inlay_hints = { enabled = true },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
      ---@type lspconfig.options
      servers = {
        eslint = {},
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        cssls = {
          settings = {},
        },
        emmet_ls = {
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "markdown",
            "vue",
          },
          init_options = { -- better html/css snippets supported
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L26
                ["bem.enabled"] = true,
              },
            },
          },
        },
        jsonls = {
          -- settings = {
          --   json = {
          --     schemas = (function()
          --       return require("schemastore").json.schemas()
          --     end)(),
          --     validate = { enable = true },
          --   },
          -- },
        },
        -- tsserver = {
        --   root_dir = function(...)
        --     local util = require("lspconfig.util")
        --     local git_root = util.root_pattern(".git")(...)
        --     if git_root then
        --       return git_root
        --     end
        --     local lockfile_root = util.root_pattern("package-lock.json")(...)
        --     if lockfile_root then
        --       return lockfile_root
        --     end
        --     local pnpm_lock_root = util.root_pattern("pnpm-lock.yaml")(...)
        --     if pnpm_lock_root then
        --       return pnpm_lock_root
        --     end
        --     return require("lspconfig.util").root_pattern("node_modules")(...)
        --   end,
        --   single_file_support = false,
        --   settings = {
        --     typescript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "literal",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --     javascript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "all",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --   },
        -- },
        volar = {
          root_dir = function(...)
            local util = require("lspconfig.util")
            -- local git_root = util.root_pattern(".git")(...)
            -- if git_root then
            --   return git_root
            -- end
            -- local lockfile_root = util.root_pattern("package-lock.json")(...)
            -- if lockfile_root then
            --   return lockfile_root
            -- end
            -- local pnpm_lock_root = util.root_pattern("pnpm-lock.yaml")(...)
            -- if pnpm_lock_root then
            --   return pnpm_lock_root
            -- end
            -- return require("lspconfig.util").root_pattern("node_modules")(...)
            return util.root_pattern(".git")(...)
          end,
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
          settings = {
            volar = {
              codeLens = {
                references = true,
                pugTools = true,
                scriptSetupTools = true,
              },
              takeOverMode = {
                extension = "Vue.volar",
              },
            },
            -- vue = {},
            init_options = {
              typescript = {
                serverPath = "E:/nvm/node_global/node_modules/typescript/lib/tsserverlibrary.js",
              },
            },
            -- on_new_config = function(config, root_dir)
            --   local function get_ts_path(dir)
            --     local util = require("lspconfig.util")
            --
            --     local global_ts = "E:/nvm/node_global/node_modules/typescript/lib/tsserverlibrary.js"
            --     -- Alternative location if installed as root:
            --     -- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
            --     local found_ts = ""
            --     local function check_dir(path)
            --       found_ts = util.path.join(path, "node_modules", "typescript", "lib", "tsserverlibrary.js")
            --       if util.path.exists(found_ts) then
            --         return path
            --       end
            --     end
            --     if util.search_ancestors(dir, check_dir) then
            --       return found_ts
            --     else
            --       return global_ts
            --     end
            --   end
            --   config.init_options.typescript.serverPath = get_ts_path(root_dir)
            -- end,
          },
        },
      },
    },
  },
}
