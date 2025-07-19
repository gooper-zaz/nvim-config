return {
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    event = 'VeryLazy',
    ---@type NoiceConfig
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          -- ['cmp.entry.get_documentation'] = true,
        },
        hover = {
          enabled = true,
          silent = true,
          ---@type NoiceViewOptions
          opts = {
            border = { style = 'rounded' },
            size = {
              max_width = math.floor(vim.o.columns * 0.7), -- 最大宽度 屏幕的70%
              max_height = math.floor(vim.o.lines * 0.5), -- 最大高度 屏幕的50%
            },
          },
        },
        signature = {
          enabled = true,
          ---@type NoiceViewOptions
          opts = {
            border = { style = 'rounded' },
            size = {
              max_width = math.floor(vim.o.columns * 0.7), -- 最大宽度 屏幕的70%
              max_height = math.floor(vim.o.lines * 0.5), -- 最大高度 屏幕的50%
            },
          },
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope)" },
      { "<leader>snh", function() Snacks.notifier.show_history() end, desc = "Notifier History (Snacks)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
      { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
    config = function(_, opts)
      require('noice').setup(opts)
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    opts = {},
  },
}
