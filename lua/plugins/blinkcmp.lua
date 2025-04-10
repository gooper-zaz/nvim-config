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
    },
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        -- compat = {},
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
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
          menu = { auto_show = true },
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

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-p>'] = { 'snippet_forward', 'fallback' },
        ['<C-t>'] = { 'snippet_backward', 'fallback' },
      },
      completion = {
        menu = {
          border = 'rounded',
          draw = {
            columns = {
              { 'label', 'label_description', gap = 4 },
              { 'kind_icon', 'kind', gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = 'rounded' },
        },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      signature = {
        window = { border = 'rounded' },
      },
    },
  },
}
