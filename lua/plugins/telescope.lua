---@diagnostic disable: assign-type-mismatch
---@type LazySpec[]
return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'find files' },
      { '<leader>fF', '<cmd>Telescope find_files<cr>', desc = 'find files (cwd)' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'file grep' },
      {
        '<leader>fb',
        '<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=false<cr>',
        desc = 'find buffers',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'find word under cursor',
        mode = { 'n', 'v' },
      },
      {
        '<leader>sW',
        function()
          Snacks.picker.grep_word({
            dirs = {
              -- 当前文件所在目录
              vim.fn.expand('%:p:h'),
            },
          })
        end,
        desc = 'find word under cursor in current file',
        mode = { 'n', 'v' },
      },
      {'<leader>sl', function() Snacks.picker.lines() end, 'search inlines in current buffer'},
      {'<leader>su', function() Snacks.picker.undo() end, 'undo history'},
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'search in current buffer' },
      { '<leader>sj', '<cmd>Telescope jumplist<cr>', desc = 'jumplist' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'keymaps' },
      { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'marks' },
      { '<leader>sq', '<cmd>Telescope quickfix<cr>', desc = 'quickfix' },
      { '<leader>st', '<cmd>Telescope treesitter<cr>', desc = 'treesitter' },
      { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Buffer Diagnostics' },
      { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace Diagnostics' },
      {
        '<leader>fs',
        function()
          require('telescope.builtin').lsp_document_symbols()
        end,
        desc = 'Find Symbols',
      },
      {
        '<leader>fS',
        function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols()
        end,
        desc = 'Find Symbols (Workspace)',
      },
    },
    opts = function()
      local action = require('telescope.actions')
      return {
        defaults = {
          selection_caret = ' ',
          theme = 'dropdown',
          sorting_strategy = 'ascending',
          dynamic_preview_title = true,
          layout_config = {
            prompt_position = 'top',
            horizontal = {
              preview_width = 0.5,
            },
          },
          file_ignore_patterns = { '.git\\', 'node_modules', 'lazy-lock.json' },
          mappings = {
            n = {
              ['q'] = action.close,
              ['<C-l>'] = action.preview_scrolling_right,
              ['<C-h>'] = action.preview_scrolling_left,
            },
            i = {
              ['<C-v>'] = false, -- conflict in windows terminal
              -- NOTE: instead of <C-v>, use <C-b> to select vertically
              ['<C-b>'] = action.select_vertical,
              ['<C-l>'] = action.preview_scrolling_right,
              ['<C-h>'] = action.preview_scrolling_left,
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
      -- telescope.load_extension('file_browser') -- 文件浏览器
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    enabled = false,
    cmd = 'Telescope',
    keys = {
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
    },
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  -- 执行全局搜索和替换的插件
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>rr',
        function()
          local grug = require('grug-far')
          local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
      {
        '<leader>rR',
        function()
          local grug = require('grug-far')
          grug.open({
            transient = true,
            prefills = {
              paths = vim.fn.expand('%'),
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace in Current File',
      },
      {
        '<leader>rw',
        function()
          local grug = require('grug-far')
          grug.open({
            transient = true,
            prefills = {
              search = vim.fn.expand('<cword>'),
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search Word Under Cursor',
      },
      {
        '<leader>rW',
        function()
          local grug = require('grug-far')
          grug.open({
            transient = true,
            prefills = {
              paths = vim.fn.expand('%'),
              search = vim.fn.expand('<cword>'),
            },
          })
        end,
        mode = { 'n', 'v' },
        desc = 'Search Word Under Cursor in Current File',
      },
    },
  },
}
