return {
  {
    'mfussenegger/nvim-lint',
    event = { 'User Laziest' },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        javascript = { 'oxlint' },
        javascriptreact = { 'oxlint' },
        typescript = { 'oxlint' },
        typescriptreact = { 'oxlint' },
        vue = { 'oxlint' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function()
          vim.schedule(function()
            lint.try_lint()
          end)
        end,
      })
    end,
  },
}
