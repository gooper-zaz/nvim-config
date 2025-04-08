return {
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    'echasnovski/mini.ai',
    event = 'BufReadPost',
    opts = function()
      local ai = require('mini.ai')
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }), -- class
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      local ai = require('mini.ai')
      ai.setup(opts)
    end,
  },
  {
    'echasnovski/mini.surround',
    event = 'BufReadPost',
    opts = {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    },
  },
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPost',
    opts = function()
      local hi = require('mini.hipatterns')
      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
          shorthand = {
            pattern = '()#%x%x%x()%f[^%x%w]',
            group = function(_, _, data)
              ---@type string
              local match = data.full_match
              local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
              local hex_color = '#' .. r .. r .. g .. g .. b .. b

              return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
            end,
            extmark_opts = { priority = 2000 },
          },
        },
      }
    end,
    config = function(_, opts)
      require('mini.hipatterns').setup(opts)
    end,
  },
  {
    'echasnovski/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          local mini = require('mini.files')
          if not mini.close() then
            mini.open()
          end
        end,
        desc = 'Open Dir/File with mini.files',
      },
    },
    opts = {},
    config = function(_, opts)
      require('mini.files').setup(opts)
    end,
  },
}
