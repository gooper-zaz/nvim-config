---@type LazySpec[]
return {
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>td', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Trouble Diagnostics' },
    },
    opts = {},
  },
  {
    -- 使用'jk'退出insert mode
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    opts = {
      mappings = {
        i = {
          j = {
            k = '<Esc>',
            j = false, -- disable 'jj'
          },
        },
      },
    },
    config = function(_, opts)
      require('better_escape').setup(opts)
    end,
  },
  -- 在bufferline下边显示面包屑状态栏, 包含当前文件路径, 当前所在符号等
  {
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    event = { 'User Laziest' },
    ---@type dropbar_configs_t
    opts = {
      menu = {
        keymaps = {
          ['Q'] = function()
            -- close all menus
            local utils = require('dropbar.utils')
            utils.menu.exec('close')
            utils.bar.exec('update_current_context_hl')
          end,
          -- open menu like '<CR>'
          ['l'] = function()
            local utils = require('dropbar.utils')
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
          -- close menu like '<ESC>'
          ['h'] = '<C-w>q',
        },
        win_configs = {
          border = 'rounded',
        },
      },
    },
    config = function(_, opts)
      local util = require('config.util')
      local api = require('dropbar.api')
      util.set_keymap('n', '<leader>cp', api.pick, { desc = 'Context Pick (dropbar)' })
      util.set_keymap('n', '[;', api.goto_context_start, { desc = 'Go to Start of Current Context' })
      util.set_keymap('n', '];', api.select_next_context, { desc = 'Select Next Context' })
      require('dropbar').setup(opts)
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'User Laziest',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = ' ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
    },
  },
  -- 用来快速生成fucntion class type等文档注释
  -- 比如可以快速生成jsdoc/tsdoc
  {
    'danymat/neogen',
    cmd = 'Neogen',
    keys = {
      {
        '<leader>cn',
        function()
          require('neogen').generate({ snippet_engine = 'mini' })
        end,
        desc = 'Generate Annotations (Neogen)',
      },
    },
    opts = {},
  },
  {
    'monaqa/dial.nvim',
    desc = 'Increment and decrement numbers, dates, and more',
    cmd = {
      'DialIncrement',
      'DialDecrement',
    },
    keys = {
      {
        '+',
        function()
          require('dial.map').manipulate('increment', 'normal')
        end,
        desc = 'Increment',
        mode = { 'n', 'v' },
      },
      {
        '-',
        function()
          require('dial.map').manipulate('decrement', 'normal')
        end,
        desc = 'Decrement',
        mode = { 'n', 'v' },
      },
      -- { 'g+', 'g<cmd>DialIncrement<cr>', desc = 'Increment', mode = { 'n', 'v' } },
      -- { 'g-', 'g<cmd>DialDecrement<cr>', desc = 'Decrement', mode = { 'n', 'v' } },
    },
    opts = function()
      local augend = require('dial.augend')

      local logical_alias = augend.constant.new({
        elements = { '&&', '||' },
        word = false,
        cyclic = true,
      })

      local ordinal_numbers = augend.constant.new({
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up
        elements = {
          'first',
          'second',
          'third',
          'fourth',
          'fifth',
          'sixth',
          'seventh',
          'eighth',
          'ninth',
          'tenth',
        },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      })

      local weekdays = augend.constant.new({
        elements = {
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        },
        word = true,
        cyclic = true,
      })

      local months = augend.constant.new({
        elements = {
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        },
        word = true,
        cyclic = true,
      })

      local capitalized_boolean = augend.constant.new({
        elements = {
          'True',
          'False',
        },
        word = true,
        cyclic = true,
      })

      return {
        dials_by_ft = {
          css = 'css',
          vue = 'vue',
          javascript = 'typescript',
          typescript = 'typescript',
          typescriptreact = 'typescript',
          javascriptreact = 'typescript',
          json = 'json',
          lua = 'lua',
          markdown = 'markdown',
          sass = 'css',
          scss = 'css',
          python = 'python',
        },
        groups = {
          default = {
            augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
            augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
            augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
            augend.date.alias['%Y/%m/%d'], -- date (2022/02/19, etc.)
            ordinal_numbers,
            weekdays,
            months,
            capitalized_boolean,
            augend.constant.alias.bool, -- boolean value (true <-> false)
            logical_alias,
          },
          vue = {
            augend.constant.new({ elements = { 'let', 'const' } }),
            augend.hexcolor.new({ case = 'lower' }),
            augend.hexcolor.new({ case = 'upper' }),
          },
          typescript = {
            augend.constant.new({ elements = { 'let', 'const' } }),
          },
          css = {
            augend.hexcolor.new({
              case = 'lower',
            }),
            augend.hexcolor.new({
              case = 'upper',
            }),
          },
          markdown = {
            augend.constant.new({
              elements = { '[ ]', '[x]' },
              word = false,
              cyclic = true,
            }),
            augend.misc.alias.markdown_header,
          },
          json = {
            augend.semver.alias.semver, -- versioning (v1.1.2)
          },
          lua = {
            augend.constant.new({
              elements = { 'and', 'or' },
              word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
              cyclic = true, -- "or" is incremented into "and".
            }),
          },
          python = {
            augend.constant.new({
              elements = { 'and', 'or' },
            }),
          },
        },
      }
    end,
    config = function(_, opts)
      -- copy defaults to each group
      for name, group in pairs(opts.groups) do
        if name ~= 'default' then
          vim.list_extend(group, opts.groups.default)
        end
      end
      require('dial.config').augends:register_group(opts.groups)
      vim.g.dials_by_ft = opts.dials_by_ft
    end,
  },
}
