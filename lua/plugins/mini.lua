return {
  {
    'echasnovski/mini.pairs',
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    opts = {},
  },
  {
    'echasnovski/mini.surround',
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
