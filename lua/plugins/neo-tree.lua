return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  enabled = false,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Neotree toggle", mode = { "n", "v" } }
  },
  config = function()
    -- vim.keymap.set({ "n", "v" }, "<leader>e", [[<cmd>Neotree toggle<CR>]])
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("DiagnosticSignError",
      { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
      { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
      { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
      { text = "󰌵", texthl = "DiagnosticSignHint" })

    -- config
    require("neo-tree").setup({
      auto_clean_after_session_restore = true,
      close_if_last_window = false,                                      -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = true,                                          -- git status on tree
      enable_diagnostics = true,
      enable_normal_mode_for_inputs = false,                             -- Enable normal mode for input dialogs.
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
      sort_function = nil,                                               -- use a custom function for sorting files and directories in the tree
      sources = { "filesystem", "buffers", "git_status" },
      sources_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem",  display_name = "File" },
          { source = "buffers",     display_name = "Bufs" },
          { source = "git_status",  display_name = "Git" },
          { source = "diagnostics", display_name = "Diagnostic" },
        }
      },
      default_component_configs = {
        container = {
          enable_character_fade = true
        },
        indent = {
          indent_size = 2, -- 缩进
          padding = 1,     -- extra padding on left hand sides
          with_markers = true,
          indent_marker = "│",
          expander_collapsed = "",
          expander_expanded = "",
        },
      },
      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          -- F = utils.is_available "telescope.nvim" and "find_in_dir" or nil,
          O = "system_open",
          Y = "copy_selector",
          h = "parent_or_close",
          l = "child_or_open",
          o = "open",
        },
      }
    })
  end
}
