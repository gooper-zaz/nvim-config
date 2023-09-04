return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local tools = {
			"eslint_d",
			"prettier",
		}
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting

		require("mason-null-ls").setup({
			ensure_installed = tools,
			handlers = {},
		})

		null_ls.setup({
			sources = {
				formatting.prettier,
			},
		})
	end,
}
