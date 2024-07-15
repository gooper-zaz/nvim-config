return {
  {
    'telescope.nvim',
    opts = {
      extensions = {
        file_browser = {
          theme = 'dropdown',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          initial_mode = 'normal',
        },
      },
    },
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>bf', '<cmd>Telescope file_browser<CR>', { noremap = true }, desc = 'Telescope File Browser' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('file_browser')
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = { '.git', '.DS_Store' },
        },
      },
    },
  },
  {
    'axelvc/template-string.nvim',
    opts = {},
  },
  {
    'mg979/vim-visual-multi',
    opt = {},
  },
}
