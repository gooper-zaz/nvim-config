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
  -- 显示当前文件的结构大纲, 类似vscode的大纲视图
  {
    'hedyhli/outline.nvim',
    keys = { { '<leader>ol', '<cmd>Outline<cr>', desc = 'Toggle Outline' } },
    cmd = 'Outline',
    opts = function()
      local defaults = require('outline.config').defaults
      local icons = require('config.icons').get_icons()
      local opts = {
        symbols = {
          icons = {},
        },
      }
      for kind, symbol in pairs(defaults.symbols.icons) do
        opts.symbols.icons[kind] = {
          icon = icons.kinds[kind] or symbol.icon,
          hl = symbol.hl,
        }
      end
      return opts
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = false,
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute({ toggle = true })
        end,
        desc = 'Explorer NeoTree (Root Dir)',
      },
      {
        '<leader>E',
        function()
          require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = 'Explorer NeoTree (cwd)',
      },
      -- { '<leader>e', '<leader>fe', desc = 'Explorer NeoTree (Root Dir)', remap = true },
      -- { '<leader>E', '<leader>fE', desc = 'Explorer NeoTree (cwd)', remap = true },
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute({ source = 'git_status', toggle = true })
        end,
        desc = 'Git Explorer',
      },
      {
        '<leader>be',
        function()
          require('neo-tree.command').execute({ source = 'buffers', toggle = true })
        end,
        desc = 'Buffer Explorer',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
        desc = 'Start Neo-tree with directory',
        once = true,
        callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == 'directory' then
              require('neo-tree')
            end
          end
        end,
      })
    end,
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 32,
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard',
          },
          ['O'] = {
            function(state)
              require('lazy.util').open(state.tree:get_node().path, { system = true })
            end,
            desc = 'Open with System Application',
          },
          ['P'] = { 'toggle_preview', config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        git_status = {
          symbols = {
            unstaged = '󰄱',
            staged = '󰱒',
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      -- 当文件移动或重命名时, 同步调用LSP的文件重命名功能, 以便更新符号引用等
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require('neo-tree').setup(opts)
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },
}
