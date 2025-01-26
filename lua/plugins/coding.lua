return {
  {
    'saghen/blink.cmp',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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

        -- cmdline = {
        --   preset = 'enter',
        -- },
      },
      completion = {
        menu = { border = 'single' },
        documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = 'single' } },
        list = { selection = { preselect = false, auto_insert = true } },
      },
      sources = {
        default = { 'buffer', 'lsp', 'path', 'snippets' },
        providers = {
          buffer = { score_offset = 1 },
          path = { score_offset = 2 },
          snippets = { score_offset = 3 },
          lsp = { score_offset = 4 },
        },
      },
      signature = { window = { border = 'single' } },
    },
  },
}
