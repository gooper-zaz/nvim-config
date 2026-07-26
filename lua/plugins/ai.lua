return {
  -- opencode.nvim
  {
    'nickjvandyke/opencode.nvim',
    -- version = '*', -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        'folke/snacks.nvim',
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require('opencode').snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        '<leader>oa',
        function()
          require('opencode').ask('@buffer: ')
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (Buffer)',
      },
      {
        '<leader>oa',
        function()
          require('opencode').ask('@this: ')
        end,
        mode = { 'v' },
        desc = 'Opencode Ask (Selection)',
      },
      {
        '<leader>ob',
        function()
          require('opencode').ask('@buffers: ')
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (All Buffers)',
      },
      {
        '<leader>od',
        function()
          require('opencode').ask('@diagnostics: ')
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (Diagnostics)',
      },
      {
        '<leader>oq',
        function()
          require('opencode').ask('@quickfix: ')
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (Quickfix)',
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          url = 'http://localhost:4096',
          start = false,
        },
      }
    end,
  },
}
