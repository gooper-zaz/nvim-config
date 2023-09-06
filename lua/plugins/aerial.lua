return {
	-- 在右侧显示文件大纲
	"stevearc/aerial.nvim",
	keys = {
		{ "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Aerial Toggle", mode = { "n", "v" } },
	},
	config = function()
		require("aerial").setup({
			backends = { "lsp", "treesitter", "markdown" },
			layout = {
				-- These control the width of the aerial window.
				-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_width and max_width can be a list of mixed types.
				-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
				max_width = { 40, 0.2 },
				width = 30,
				min_width = 10,

				-- key-value pairs of window-local options for aerial window (e.g. winhl)
				win_opts = {},

				-- Determines the default direction to open the aerial window. The 'prefer'
				-- options will open the window in the other direction *if* there is a
				-- different buffer in the way of the preferred direction
				-- Enum: prefer_right, prefer_left, right, left, float
				default_direction = "prefer_right",

				-- Determines where the aerial window will be opened
				--   edge   - open aerial at the far right/left of the editor
				--   window - open aerial to the right/left of the current window
				placement = "window",

				-- When the symbols change, resize the aerial window (within min/max constraints) to fit
				resize_to_content = true,

				-- Preserve window size equality with (:help CTRL-W_=)
				preserve_equality = false,
			},
			-- When true, don't load aerial until a command or function is called
			-- Defaults to true, unless `on_attach` is provided, then it defaults to false
			lazy_load = true,

			-- Disable aerial on files with this many lines
			disable_max_lines = 10000,

			-- Disable aerial on files this size or larger (in bytes)
			disable_max_size = 2000000, -- Default 2MB

			-- A list of all symbols to display. Set to false to display all symbols.
			-- This can be a filetype map (see :help aerial-filetype-map)
			-- To see all available values, see :help SymbolKind
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Method",
				"Struct",
			},
			lsp = {
				-- Fetch document symbols when LSP diagnostics update.
				-- If false, will update on buffer changes.
				diagnostics_trigger_update = true,

				-- Set to false to not update the symbols when there are LSP errors
				update_when_errors = true,

				-- How long to wait (in ms) after a buffer change before updating
				-- Only used when diagnostics_trigger_update = false
				update_delay = 300,

				-- Map of LSP client name to priority. Default value is 10.
				-- Clients with higher (larger) priority will be used before those with lower priority.
				-- Set to -1 to never use the client.
				priority = {
					-- pyright = 10,
				},
			},

			treesitter = {
				-- How long to wait (in ms) after a buffer change before updating
				update_delay = 300,
				-- Experimental feature to navigate to symbol names instead of the declaration
				-- See https://github.com/stevearc/aerial.nvim/issues/279
				-- If no bugs are reported for a time this will become the default
				experimental_selection_range = false,
			},
		})
	end,
}
