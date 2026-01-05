return {
  {
    'mfussenegger/nvim-lint',
    event = { 'User Laziest' },
    opts = {
      -- Event to trigger linters
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        javascript = { 'oxlint', 'eslint' },
        javascriptreact = { 'oxlint', 'eslint' },
        typescript = { 'oxlint', 'eslint' },
        typescriptreact = { 'oxlint', 'eslint' },
        vue = { 'oxlint', 'eslint' },
      },
    },
    config = function(_, opts)
      local M = {}
      local lint = require('lint')
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          if not timer then
            vim.notify('Timer not available for linting debounce', vim.log.levels.WARN)
            return
          end
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        lint.try_lint()
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
}
