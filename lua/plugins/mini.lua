return {
  {
    'echasnovski/mini.pairs',
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
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = {
        'css',
        'scss',
        'html',
        'vue',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'lua',
      },
      user_default_options = {
        rgb_fn = true, -- Enable RGB function support
        hsl_fn = true, -- Enable HSL function support
        sass = {
          enable = true, -- Enable Sass color support
          parsers = { 'css' },
        },
      },
    },
    config = function(_, opts)
      require('colorizer').setup(opts)
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

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local cur_target = MiniFiles.get_explorer_state().target_window
          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. ' split')
            return vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target)

          -- This intentionally doesn't act on file under cursor in favor of
          -- explicit "go in" action (`l` / `L`). To immediately open file,
          -- add appropriate `MiniFiles.go_in()` call instead of this comment.
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, 'sp', 'belowright horizontal')
          map_split(buf_id, 'sl', 'belowright vertical')
          -- map_split(buf_id, '<C-t>', 'tab')
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
    end,
  },
  {
    'echasnovski/mini.jump',
    event = 'BufReadPost',
    opts = {},
  },
  {
    'echasnovski/mini.jump2d',
    event = { 'BufReadPost' },
    opts = {},
  },
  {
    'echasnovski/mini.comment',
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

        -- define 'comment' textobject (like `dic` - delete whole comment block)
        -- works also in visual mode if mapping differs from `comment_visual`
        textobject = 'ic',
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
