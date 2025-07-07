---@diagnostic disable: missing-fields
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
    event = { 'User Laziest' },
    opts = {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
      },
      sections = {
        lualine_x = { 'filetype' },
        lualine_y = {
          { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date('%R')
          end,
        },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = { 'User Laziest' },
    keys = {
      { '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev Buffer' },
      { '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move Buffer Prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move Buffer Next' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<leader>bp', '<Cmd>BufferLinePick<CR>', desc = 'Buffer Pick' },
      {
        '<leader>bd',
        function()
          require('snacks.bufdelete').delete()
        end,
        desc = 'Delete Current Buffer',
      },
      {
        '<leader>bo',
        function()
          require('snacks.bufdelete').other()
        end,
        desc = 'Delete Other Buffers',
      },
    },
    ---@type bufferline.Config
    opts = {
      options = {
        close_command = function(n)
          require('snacks.bufdelete').delete({
            buf = n.bufnr,
          })
        end,
        show_buffer_close_icons = false,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diag)
          local all_icons = require('config.icons').get_icons()
          local icons = all_icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
      },
    },
    config = function(_, opts)
      if (vim.g.colors_name or ''):find('catppuccin') then
        opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
      end

      require('bufferline').setup(opts)
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    ---@type snacks.Config
    opts = {
      indent = { enabled = true },
      bigfile = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      input = { enabled = true },
      words = { enabled = true },
      git = { enabled = true },
      scroll = { enabled = false },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ['<C-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
              ['<C-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['<C-h>'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
              ['<C-l>'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
            },
          },
        },
        previewers = {
          file = {
            max_size = 100 * 1024 * 5, -- 5 MB
          },
        },
      },
      dashboard = {
        preset = {
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = "<cmd>Telescope find_files<cr>" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = "<cmd>Telescope live_grep<cr>" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "󰰑 ", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
