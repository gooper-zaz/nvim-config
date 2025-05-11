---@diagnostic disable: missing-fields
return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    ---@type Gitsigns.Config
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
      on_attach = function(buffer)
        local gs = require('gitsigns')

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, 'Next Hunk')

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, 'Prev Hunk')

        map('n', ']H', function()
          gs.nav_hunk('last')
        end, 'Last Hunk')

        map('n', '[H', function()
          gs.nav_hunk('first')
        end, 'First Hunk')

        map('n', '<leader>gp', gs.preview_hunk_inline, 'Preview Hunk Inline')

        map('n', '<leader>gb', function()
          gs.blame_line({ full = true })
        end, 'Blame Line')

        map('n', '<leader>gB', function()
          gs.blame()
        end, 'Blame Buffer')
      end,
    },
    -- config = function(_, opts)
    --   require('gitsigns').setup(opts)
    -- end,
  },
}
