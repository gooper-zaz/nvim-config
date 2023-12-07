return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        -- NOTE: 先尝试用perttierd格式化, 若调用失败或项目中没有配置prettier, 则使用eslint_d.
        javascript = { { 'prettierd', 'eslint_d' } },
        javascriptreact = { { 'prettierd', 'eslint_d' } },
        typescript = { { 'prettierd', 'eslint_d' } },
        typescriptreact = { { 'prettierd', 'eslint_d' } },
        vue = { { 'prettierd', 'eslint_d' } },
        json = { { 'prettierd', 'prettier' } },
        jsonc = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        sass = { { 'prettierd', 'prettier' } },
        less = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
      },
    },
  },
}
