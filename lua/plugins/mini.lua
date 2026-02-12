return {
  {
    'nvim-mini/mini.pairs',
    event = { 'InsertEnter' },
    opts = {
      modes = { insert = true, command = false, terminal = false },
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
    'nvim-mini/mini.ai',
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
    'nvim-mini/mini.surround',
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
    'nvim-mini/mini.files',
    keys = {
      {
        '<leader>e',
        function()
          local mini = require('mini.files')
          if not mini.close() then
            mini.open(vim.uv.cwd(), true)
          end
        end,
        desc = 'Open Dir/File with mini.files (cwd)',
      },
      {
        '<leader>E',
        function()
          local mini = require('mini.files')
          if not mini.close() then
            mini.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = 'Open Dir/File with mini.files',
      },
    },
    opts = {
      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = 'q',
        -- 把默认的go_in 和 go_in_plus快捷键调换了
        go_in = 'L',
        go_in_plus = 'l',
        -- 把默认的go_out 和 go_out_plus快捷键调换了
        go_out = 'H',
        go_out_plus = 'h',
        mark_goto = "'",
        mark_set = 'm',
        reset = '<BS>',
        reveal_cwd = '@',
        show_help = 'g?',
        synchronize = '=',
        trim_left = '<',
        trim_right = '>',
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
    },
    config = function(_, opts)
      require('mini.files').setup(opts)

      local show_dotfiles = true

      local filter_show = function(fs_entry)
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle Dotfiles' })
        end,
      })

      --- set mini.files buffer keymaps
      ---@param buf_id number buffer number
      ---@param lhs string left-hand side of the keymap
      ---@param direction string direction for split
      ---@param close_on_file boolean whether to close mini.files on file open
      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require('mini.files').get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd('belowright ' .. direction .. ' split')
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require('mini.files').set_target_window(new_target_window)
            require('mini.files').go_in({ close_on_file = close_on_file })
          end
        end

        local desc = 'Open in ' .. direction .. ' split'
        if close_on_file then
          desc = desc .. ' and close'
        end
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      -- 搜索当前文件夹下的文件
      local map_find_files = function(buf_id, lhs)
        vim.keymap.set('n', lhs, function()
          local entry = MiniFiles.get_fs_entry() or {}
          -- 如果光标所在的条目是文件, 那么就不进行搜索
          if entry.fs_type == 'file' then
            return
          end

          local path = entry.path
          if path == nil then
            return vim.notify('Cursor is not on valid entry')
          end

          -- WARN: 先关闭 mini.files 窗口, 防止mini.files关闭自身时将搜索结果也关闭了
          MiniFiles.close()

          -- 这里使用了 Telescope 来进行搜索, 你也可以换成其他的工具
          require('telescope.builtin').find_files({ cwd = path })
          -- Snacks.picker.files({ cwd = path })
        end, { buffer = buf_id, desc = 'find files in current directory' })
      end

      -- 搜索当前文件夹下的内容
      local map_search = function(buf_id, lhs)
        vim.keymap.set('n', lhs, function()
          local entry = MiniFiles.get_fs_entry() or {}
          -- 如果光标所在的条目是文件, 那么就不进行搜索
          if entry.fs_type == 'file' then
            return
          end
          local path = entry.path
          if path == nil then
            return vim.notify('Cursor is not on valid entry')
          end

          -- WARN: 先关闭 mini.files 窗口, 防止mini.files关闭自身时将搜索结果也关闭了
          MiniFiles.close()

          -- 这里使用了 Telescope 来进行搜索, 你也可以换成其他的工具
          require('telescope.builtin').live_grep({ cwd = path })
          -- Snacks.picker.grep({ cwd = path })
        end, { buffer = buf_id, desc = 'search in current directory' })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, 'ss', 'belowright horizontal', false)
          map_split(buf_id, 'sv', 'belowright vertical', false)
          -- map_split(buf_id, '<C-t>', 'tab')
          map_find_files(buf_id, 'sf')
          map_search(buf_id, 'sg')
        end,
      })

      -- 在 MiniFiles 窗口中启用行号和相对行号
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowUpdate',
        callback = function(args)
          vim.wo[args.data.win_id].number = true
          vim.wo[args.data.win_id].relativenumber = true
        end,
      })

      -- LSP-integrated file renaming
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesActionRename',
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })

      -- git integration
      -- require('config.mini-files-git')
    end,
  },
  {
    'nvim-mini/mini.jump',
    event = 'BufReadPost',
    opts = {},
  },
  {
    'nvim-mini/mini.jump2d',
    event = { 'BufReadPost' },
    opts = {},
  },
  {
    'nvim-mini/mini.comment',
    event = { 'BufReadPost' },
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',

        -- Toggle comment on current line
        comment_line = 'gcc',

        -- Toggle comment on visual selection
        comment_visual = 'gc',

        -- define 'comment' textobject (like `dik` - delete whole comment block)
        -- works also in visual mode if mapping differs from `comment_visual`
        textobject = 'ik', -- `ic` already used by mini.ai for `class` textobject
      },
    },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
}
