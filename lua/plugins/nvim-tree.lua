-- 默认不开启nvim-tree
return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    name = "nvim-tree",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Open the nvim-tree", mode = { "n", "v" } },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        filters = {
          custom = { "^.git$", "^node_modules$" },
        },
      })
    end,
  },
}
