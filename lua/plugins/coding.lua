return {
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      return {}
    end,
  },
  {

    'hrsh7th/cmp-cmdline', -- cmd 命令补全
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    event = { 'CmdlineEnter' },
    config = function()
      local cmp = require('cmp')
      -- cmdline 自动补全路径和命令
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<CR>'] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
        }),
      })
      -- cmdline 输入":", 搜索buffer下的文本
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline({
          ['<CR>'] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = {
          { name = 'buffer' },
        },
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer', -- buffer 字符补全
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      table.insert(opts.sources, { name = 'buffer' })
      table.insert(opts.sources, {
        name = 'nvim_lsp',
        entry_filter = function(entry, ctx)
          -- Check if the buffer type is 'vue'
          if ctx.filetype ~= 'vue' then
            return true
          end

          local cursor_before_line = ctx.cursor_before_line
          -- For events
          if cursor_before_line:sub(-1) == '@' then
            return entry.completion_item.label:match('^@')
            -- For props also exclude events with `:on-` prefix
          elseif cursor_before_line:sub(-1) == ':' then
            return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on-')
          else
            return true
          end
        end,
        priority = 1000,
      })

      local cmp = require('cmp')
      local luasnip = require('luasnip')
      opts.mapping = {
        -- backwards 向后翻页
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        -- forward 向前翻页
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-n>'] = cmp.mapping.abort(), -- 取消补全，esc也可以退出

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<S-CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-CR>'] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }

      opts.window = {
        completion = cmp.config.window.bordered({
          col_offset = 1,
          side_padding = 1,
          scrollbar = false,
        }),
        documentation = cmp.config.window.bordered({
          col_offset = 1,
          side_padding = 1,
          scrollbar = false,
        }),
      }
      -- cmp.event:on('menu_closed', function()
      --   local bufnr = vim.api.nvim_get_current_buf()
      --   vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
      -- end)
    end,
  },
}
