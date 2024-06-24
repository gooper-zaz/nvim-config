return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        -- NOTE: 先尝试用perttierd格式化, 若调用失败或项目中没有配置prettier, 则使用eslint_d.
        javascript = { { 'prettier', 'eslint' } },
        javascriptreact = { { 'prettier', 'eslint' } },
        typescript = { { 'prettier', 'eslint' } },
        typescriptreact = { { 'prettier', 'eslint' } },
        vue = { { 'prettier', 'eslint' } },
        json = { { 'prettier' } },
        jsonc = { { 'prettier' } },
        css = { { 'prettier' } },
        html = { { 'prettier' } },
        yaml = { { 'prettier' } },
        sass = { { 'prettier' } },
        less = { { 'prettier' } },
        markdown = { { 'prettier' } },
      },
    },
  },
}
