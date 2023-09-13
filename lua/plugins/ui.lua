return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          -- 使用 nvim 内置lsp
          diagnostics = "nvim_lsp",
          -- 左侧让出 nvim-tree 的位置
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
            -- {
            --   filetype = "NeoTree",
            --   text = "File Explorer",
            --   highlight = "Directory",
            --   text_align = "left",
            -- }
          },
        },
      })

      vim.opt.termguicolors = true
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = {},
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        modes_allowlist = { "n", "v", "i" },
        delay = 100,
        filetypes_denylist = {
          "DoomInfo",
          "DressingSelect",
          "NvimTree",
          "Outline",
          "TelescopePrompt",
          "Trouble",
          "alpha",
          "dashboard",
          "dirvish",
          "fugitive",
          "help",
          "lsgsagaoutline",
          "neogitstatus",
          "norg",
          "toggleterm",
        },
        under_cursor = false,
      })
    end,
  },
}
