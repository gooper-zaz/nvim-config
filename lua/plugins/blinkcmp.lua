return {
  {
    'saghen/blink.cmp',
    version = '*',
    -- build = 'cargo build --release',
    opts_extend = {
      'sources.completion.enabled_providers',
      'sources.compat',
      'sources.default',
    },
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- add blink.compat to dependencies
      {
        'saghen/blink.compat',
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = '*',
      },
      { 'giuxtaposition/blink-cmp-copilot' },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        -- compat = {},
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
                return 3
              end
              return 0
            end,
          },
        },
      },
      appearance = {
        -- 将后备高亮组设置为 nvim-cmp 的高亮组
        -- 当您的主题不支持blink.cmp 时很有用
        -- 将在未来版本中删除
        use_nvim_cmp_as_default = true,
        -- 将“Nerd Font Mono”设置为“mono”，将“Nerd Font”设置为“normal”
        -- 调整间距以确保图标对齐
        nerd_font_variant = 'mono',
      },
      fuzzy = {
        implementation = 'prefer_rust',
        prebuilt_binaries = {
          download = true,
        },
      },
      cmdline = {
        keymap = {
          -- 选择并接受预选择的第一个
          ['<CR>'] = { 'select_and_accept', 'fallback' },
        },
        completion = {
          -- 自动显示补全窗口
          menu = {
            -- cmd模式显示补全窗口, 搜索时不显示
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ':'
            end,
          },
          -- 不在当前行上显示所选项目的预览
          ghost_text = { enabled = false },
        },
      },
      keymap = {
        preset = 'none',

        ['<Tab>'] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            end
          end,
          'fallback',
        },
        ['<S-Tab>'] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            end
          end,
          'fallback',
        },

        ['<C-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-p>'] = { 'snippet_forward', 'fallback' },
        ['<C-t>'] = { 'snippet_backward', 'fallback' },
      },
      completion = {
        menu = {
          border = 'rounded',
          draw = {
            columns = {
              { 'kind_icon', 'label', 'label_description', gap = 2 },
              { 'source_name', gap = 1 },
              { 'kind', gap = 1 },
            },
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = 'rounded' },
        },
        list = { selection = { preselect = true, auto_insert = false } },
        accept = {
          auto_brackets = {
            enabled = false,
          },
          -- 在neovide中, accept时光标会从左上角跳到当前位置
          -- 故使用neovide时, 将此配置设置为false
          dot_repeat = not vim.g.neovide,
        },
      },
      signature = {
        window = { border = 'rounded' },
      },
    },
  },
}
