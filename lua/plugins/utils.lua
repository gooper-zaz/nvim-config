return {
	{
		"rhysd/accelerated-jk",
		keys = {
			{ "j", "<Plug>(accelerated_jk_gj)" },
			{ "k", "<Plug>(accelerated_jk_gk)" },
		},
	},
	{
		"folke/persistence.nvim",
		keys = {
			{ "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]] },
			{ "<leader>ql", [[<cmd>lua require("persistence").load({ last = true})<cr>]] },
			{ "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]] },
		},
		config = true,
	},
	-- {
	--   "windwp/nvim-autopairs",
	--   opts = {
	--     enable_check_bracket_line = false,
	--   },
	-- },
	{
		"ethanholz/nvim-lastplace",
		config = true,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
		config = true,
	},
	{
		"kamykn/spelunker.vim",
		event = "VeryLazy",
		config = function()
			vim.g.spelunker_check_type = 2
		end,
	},
	{
		"ellisonleao/glow.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		config = true,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = true,
	},
	{
		"s1n7ax/nvim-window-picker",
		opts = {
			filter_rules = {
				include_current_win = true,
				autoselect_one = true,
				bo = {
					filetype = { "fidget", "nvim-tree" },
					buftype = { "quickfix" },
				},
			},
		},
		keys = {
			{
				"<C-w>p",
				function()
					local window_number = require("window-picker").pick_window()
					if window_number then
						vim.api.nvim_set_current_win(window_number)
					end
				end,
				desc = "Pick a window",
			},
		},
	},
	{
		-- 使用'jk'退出insert mode
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
}
