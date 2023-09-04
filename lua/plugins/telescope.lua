return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		{
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},
	keys = {
		{ "<leader>?", "<cmd>lua require('telescope.builtin').oldfiles()<cr>" },
		{ "<leader><space>", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true })<cr>" },
		{
			"<leader>/",
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
		},
		{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
		{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
		{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
		{ "<leader>fp", "<cmd>lua require('telescope.builtin').builtin()<cr>" },
		{ "<leader>fb", "<cmd>Telescope file_browser<CR>", { noremap = true } },
		{ "<leader>fm", "<cmd>lua require('telescope.builtin').marks()<cr>" },
		{ "<leader>qf", "<cmd>lua require('telescope.builtin').quickfix()<cr>" },
		{ "<leader>km", "<cmd>lua require('telescope.builtin').keymaps()<cr>" },
		{ "<c-p>", "<cmd>lua require('telescope.builtin').commands()<cr>" },
	},
	config = function()
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions
		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["q"] = actions.close,
					},
					i = {
						["<C-q>"] = actions.close,
					},
				},
			},
			extensions = {
				-- 模糊搜索
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
					mappings = {
						["i"] = {
							["<C-w>"] = function()
								vim.cmd("normal vbd")
							end,
						},
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("file_browser")
		-- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
	end,
}
