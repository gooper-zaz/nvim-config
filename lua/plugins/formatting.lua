return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts_extends = { 'formatters_by_ft' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = {
        timout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        -- 自定义prettier
        -- 当项目中包含perttier的配置文件时, 优先使用项目配置; 否则使用全局预设的配置
        custom_prettier = {
          command = 'prettier',
          stdin = true,
          args = function(self, ctx)
            local util = require('conform.util')
            -- 检查是否有prettier配置文件
            local project_root = util.root_file({
              -- https://prettier.io/docs/en/configuration.html
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.json5',
              '.prettierrc.js',
              '.prettierrc.cjs',
              '.prettierrc.mjs',
              '.prettierrc.toml',
              'prettier.config.js',
              'prettier.config.cjs',
              'prettier.config.mjs',
              -- "package.json",
            })(nil, ctx)

            local prettier_args = {
              '--stdin-filepath',
              ctx.filename,
            }

            if not project_root then
              -- 没有找到配置文件，使用你的默认规则
              -- stylua: ignore
              vim.list_extend(prettier_args, {
                '--tab-width', '2',
                '--single-quote', 'true',
                '--trailing-comma', 'es5',
                '--semi', 'true',
                '--print-width', '100',
              })
            end

            return prettier_args
          end,
        },
      },
    },
  },
}
