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

      local oxlint = lint.linters.oxlint
      oxlint.args = {
        '--deny',
        'no-duplicate-imports',
        'import/no-cycle',
        '--warn',
        'no-unused-vars',
        'typescript/no-explicit-any',
        '--allow',
        'unicorn/no-new-array',
        '--format',
        'unix',
        '--import-plugin',
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
