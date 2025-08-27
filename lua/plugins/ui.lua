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
    opts = function()
      local lualine_require = require('lualine_require')
      lualine_require.require = require

      local icon_util = require('config.icons')
      local icons = icon_util.get_icons()

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = 'auto',
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_c = { 'filename' },
          lualine_x = { Snacks.profiler.status(), 'filetype', 'encoding', 'fileformat' },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            -- 'lsp_status',
            function()
              local result = {}
              local current_buf = vim.api.nvim_get_current_buf()
              local clients = vim.lsp.get_clients({ bufnr = current_buf })
              local copilot = ''
              for _, client in ipairs(clients) do
                local icon = icon_util.get_icon_by_lsp_name(client.name) or client.name
                if client.name == 'copilot' then
                  copilot = icon
                else
                  table.insert(result, icon)
                end
              end
              return #result > 0 and table.concat(result, ' ') .. (copilot ~= '' and ' ' .. copilot or '') or ''
            end,
            function()
              return ' ' .. os.date('%R')
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      if (vim.g.colors_name or ''):find('catppuccin') then
        opts.options.theme = 'catppuccin'
      end

      require('lualine').setup(opts)
    end,
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
      { '<leader>pb', '<Cmd>BufferLineTogglePin<CR>', desc = 'Pin Buffer' },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete.delete()
        end,
        desc = 'Delete Current Buffer',
      },
      { '<leader>bD', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      {
        '<leader>bo',
        function()
          Snacks.bufdelete.other()
        end,
        desc = 'Delete Other Buffers',
      },
    },
    ---@type bufferline.Config
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        show_buffer_close_icons = true,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diag)
          local all_icons = require('config.icons').get_icons()
          local icons = all_icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
            .. (diag.warning and icons.Warn .. diag.warning or '')
          return vim.trim(ret)
        end,
        offsets = {
          -- {
          --   filetype = 'neo-tree',
          --   text = 'Neo-tree',
          --   highlight = 'Directory',
          --   text_align = 'left',
          -- },
          {
            filetype = 'snacks_layout_box',
          },
        },
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
      -- indent = { enabled = true, indent = { enabled = true, char = '┊' } },
      indent = { enabled = true },
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = 'fancy',
        padding = false,
      },
      scope = { enabled = true },
      input = { enabled = true },
      words = { enabled = true },
      git = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ['<C-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
              ['<C-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
              ['<C-h>'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
              ['<C-l>'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
              ['<C-x>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
            },
          },
        },
        previewers = {
          file = {
            max_size = 100 * 1024 * 5, -- 5 MB
          },
        },
        formatters = {
          file = {
            icon_width = 3,
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
            { icon = " ", key = "g", desc = "Grep Text", action = "<cmd>Telescope live_grep<cr>" },
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
