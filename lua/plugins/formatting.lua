return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts_extends = { 'formatters_by_ft' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format()
        end,
        mode = { 'n', 'v' },
        desc = 'Code Format',
      },
    },
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
        timeout_ms = 3000,
      },
      -- format_on_save = {
      --   timout_ms = 500,
      --   lsp_format = 'fallback',
      -- },
      notify_on_error = true,
      notify_no_formatters = true,
      formatters = {
        prettier = {
          require_cwd = true,
        },
      },
    },
  },
}
