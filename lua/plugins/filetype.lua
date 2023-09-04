return {
  "nathom/filetype.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("filetype").setup({})
  end
}
