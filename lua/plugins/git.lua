---@diagnostic disable: missing-fields
return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'User Laziest' },
    ---@type Gitsigns.Config
    opts = {
      signs = {
        add = { text = '' },
        change = { text = '┃' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '┆' },
      },
      signs_staged = {
        add = { text = '' },
        change = { text = '┃' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '┆' },
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
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>gd', gs.diffthis, 'Git Diff This')
        map('n', '<leader>gD', function()
          gs.diffthis('~')
        end, 'Git Diff This ~')
        -- text objects, for example, `vih` to select the hunk under cursor
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
        -- git (telescope)
        map('n', '<leader>gc', '<cmd>Telescope git_bcommits<CR>', 'Git Commits in Current File')
        map('n', '<leader>gC', '<cmd>Telescope git_commits<CR>', 'Git Commits in Working Directory')
        map('v', '<leader>gc', '<cmd>Telescope git_bcommits_range<CR>', 'Git Commits in Current File Range')
        map('n', '<leader>gs', '<cmd>Telescope git_status<CR>', 'Git Status')
        map('n', '<leader>gq', function()
          gs.setqflist('attached')
        end, 'Git Change Quickfix List Of Current Buffer')
        map('n', '<leader>gQ', function()
          gs.setqflist('all')
        end, 'Git Change Quickfix List Of Whole Project')
      end,
    },
    -- config = function(_, opts)
    --   require('gitsigns').setup(opts)
    -- end,
  },
}
