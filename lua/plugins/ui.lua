return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
    'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    opts = {
      sections = {
        lualine_x = { 'filetype' },
        lualine_z = {},
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        mode = 'tabs',
        show_close_icon = true,
        always_show_bufferline = true,
      },
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    opts = {
      indent = { enabled = true },
      bigfile = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      input = { enabled = true },
      words = { enabled = true },
      dashboard = {
        sections = {
          { section = 'header' },
          { section = 'startup' },
        },
      },
    },
  },
}
