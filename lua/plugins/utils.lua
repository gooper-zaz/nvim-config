return {
  {
    -- 使用'jk'退出insert mode
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
}
