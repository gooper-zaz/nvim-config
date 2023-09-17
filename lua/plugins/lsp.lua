-- require("lspconfig").lua_ls.setup {
--   capabilities = capabilities,
--   group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
--   on_attach = function(_, bufnr)
--     on_attach(_, bufnr)
--   end
-- }
local utils = require("utils")
local consts = require("contants")

return {
	"neovim/nvim-lspconfig",
	cmd = { "Mason", "Neoconf" },
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
		"onsails/lspkind-nvim",
		"folke/neoconf.nvim",
		"folke/neodev.nvim",
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
		},
		"nvimdev/lspsaga.nvim",
		"SmiteshP/nvim-navic",
		-- "jose-elias-alvarez/typescript.nvim",
		"b0o/schemastore.nvim",
	},
	config = function()
		local on_attach = function(client, bufnr)
			-- 定义快捷键的函数
			-- @param keys string
			local nmap = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end

			-- 定义快捷键
			-- 跳转到声明
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			-- 跳转到定义
			nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			-- hover显示提示信息
			nmap("<leader>k", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			-- 跳转到实现
			nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			-- 签名信息
			nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
			nmap("<C-f>", "<cmd>Lspsaga finder<CR>", "Lspsaga [F]inder")
			-- 工作区添加文件夹
			nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
			-- 工作区删除文件夹
			nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
			-- 工作区文件列表
			nmap("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "[W]orkspace [L]ist Folders")
			nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			-- 重命名
			nmap("<leader>rn", "<cmd>Lspsaga rename ++project<CR>", "[R]e[n]ame")
			-- code action
			nmap("<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction")
			-- 显示代码诊断
			nmap("<leader>da", require("telescope.builtin").diagnostics, "[D]i[A]gnostics")
			-- 显示引用信息
			nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

			-- 格式化代码
			nmap("<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, "[F]ormat code")

			-- format on save
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--   buffer = bufnr,
			--   callback = function()
			--     vim.lsp.buf.format()
			--   end,
			-- })
			if client.server_capabilities.documentSymbolProvider then
				local navic = require("nvim-navic")
				navic.attach(client, bufnr)
			end
		end

		local servers = {
			lua_ls = {
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
			clangd = {},
			-- tsserver = { disabled = true },
			-- 使用volar代替tsserver, 以便在vue文件中也能使用lsp
			volar = {
				settings = {
					volar = {
						codeLens = {
							references = true,
							pugTools = true,
							scriptSetupTools = true,
						},
					},
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"javascript.jsx",
					"typescript.tsx",
					"vue",
					-- "json",
				},
				init_options = {
					documentFeatures = {
						documentColor = false,
						documentFormatting = {
							defaultPrintWidth = 100,
						},
						documentSymbol = true,
						foldingRange = true,
						linkedEditingRange = true,
						selectionRange = true,
					},
					languageFeatures = {
						callHierarchy = true,
						codeAction = true,
						codeLens = true,
						completion = {
							defaultAttrNameCase = "kebabCase",
							defaultTagNameCase = "both",
						},
						definition = true,
						diagnostics = true,
						documentHighlight = true,
						documentLink = true,
						hover = true,
						implementation = true,
						references = true,
						rename = true,
						renameFileRefactoring = true,
						schemaRequestService = true,
						semanticTokens = false,
						signatureHelp = true,
						typeDefinition = true,
					},
					typescript = {
						serverPath = consts.global_ts_server,
						-- 使用全局的typescript而不是node_module中的typescript, 你可以执行`npm install -g typescript`来安装
						tsdk = consts.global_ts_server_lib,
					},
				},
				on_new_config = function(new_config, new_root_dir)
					new_config.init_options.typescript.serverPath = utils.get_typescript_server_path(new_root_dir)
					-- new_config.init_options.typescript.tsdk = utils.get_typescript_server_path(new_root_dir)
				end,
			},
			bashls = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
		}

		require("neoconf").setup()
		require("neodev").setup()
		require("fidget").setup()

		require("lspsaga").setup({
			ui = {
				border = "rounded",
			},
		})

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason-lspconfig").setup({
			-- 确保安装，根据需要填写
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
			-- handlers = {
			--   function(server_name) -- default handler (optional)
			--     require("lspconfig")[server_name].setup({
			--       settings = servers[server_name],
			--       on_attach = on_attach,
			--       capabilities = capabilities,
			--     })
			--   end,
			-- },
		})
		for server, config in pairs(servers) do
			require("lspconfig")[server].setup(vim.tbl_deep_extend("keep", {
				on_attach = on_attach,
				capabilities = capabilities,
			}, config))
		end

		require("lspkind").init({
			mode = "symbol_text",
			preset = "codicons",
			symbol_map = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "ﰠ",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "塞",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
				TypeParameter = "",
			},
		})

		-- vim.keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
		-- vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
		-- vim.keymap.set('n', '<leader>r', '<cmd>TypescriptRemoveUnused<cr>')
	end,
}
