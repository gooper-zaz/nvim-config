return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[f]ind [f]iles' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[f]ile [g]rep' },
      { '<leader>fr', '<cmd>Telescope resume<cr>', desc = '[f]ile [r]esume' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = '[f]ind [d]iagnostisc' },
      { '<leader>fv', '<cmd>Telescope vim_options<cr>', desc = '[f]ind [v]im opts' },
      {
        '<leader>fb',
        '<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=false<cr>',
        desc = '[f]ind [b]uffers',
      },
      {
        '<leader>ft',
        '<cmd>Telescope file_browser<cr>',
        desc = '[f]ile [t]ree',
      },
      {
        '<leader>fT',
        '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
        desc = '[f]ile [t]ree with the path of the current buffer',
      },
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[s]earch in current [b]uffer' },
      { '<leader>sj', '<cmd>Telescope jumplist<cr>', desc = 'jumplist' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'keymaps' },
      { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'marks' },
      { '<leader>sq', '<cmd>Telescope quickfix<cr>', desc = 'quickfix' },
      { '<leader>st', '<cmd>Telescope treesitter<cr>', desc = 'treesitter' },
      { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Document Diagnostics' },
      { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace Diagnostics' },
      {
        '<leader>ss',
        function()
          require('telescope.builtin').lsp_document_symbols()
        end,
        desc = 'Goto Symbol',
      },
      {
        '<leader>sS',
        function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols()
        end,
        desc = 'Goto Symbol (Workspace)',
      },
      -- git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Commits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = 'Status' },
    },
    opts = function()
      local action = require('telescope.actions')
      return {
        defaults = {
          selection_caret = '󰘍 ',
          theme = 'dropdown',
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
          file_ignore_patterns = { '.git\\', 'node_modules', 'lazy-lock.json' },
          mapping = {
            n = {
              ['q'] = action.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
        extensions = {
          file_browser = {
            grouped = true,
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('file_browser') -- 文件浏览器
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
}
