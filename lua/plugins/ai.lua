return {
  {
    'yetone/avante.nvim',
    build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make',
    event = 'VeryLazy',
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'copilot',
      selection = {
        hint_display = 'none',
      },
      behaviour = {
        auto_set_keymaps = false,
      },
      windows = {
        width = 40,
      },
    },
    cmd = {
      'AvanteAsk',
      'AvanteBuild',
      'AvanteChat',
      'AvanteClear',
      'AvanteEdit',
      'AvanteFocus',
      'AvanteHistory',
      'AvanteModels',
      'AvanteRefresh',
      'AvanteShowRepoMap',
      'AvanteStop',
      'AvanteSwitchProvider',
      'AvanteToggle',
    },
    keys = {
      { '<leader>aa', '<cmd>AvanteAsk<CR>', desc = 'Ask Avante' },
      { '<leader>ac', '<cmd>AvanteChat<CR>', desc = 'Chat with Avante' },
      { '<leader>ae', '<cmd>AvanteEdit<CR>', desc = 'Edit Avante' },
      { '<leader>af', '<cmd>AvanteFocus<CR>', desc = 'Focus Avante' },
      { '<leader>ah', '<cmd>AvanteHistory<CR>', desc = 'Avante History' },
      { '<leader>am', '<cmd>AvanteModels<CR>', desc = 'Select Avante Model' },
      { '<leader>an', '<cmd>AvanteChatNew<CR>', desc = 'New Avante Chat' },
      { '<leader>ap', '<cmd>AvanteSwitchProvider<CR>', desc = 'Switch Avante Provider' },
      { '<leader>ar', '<cmd>AvanteRefresh<CR>', desc = 'Refresh Avante' },
      { '<leader>as', '<cmd>AvanteStop<CR>', desc = 'Stop Avante' },
      { '<leader>at', '<cmd>AvanteToggle<CR>', desc = 'Toggle Avante' },
    },
  },
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
          require('opencode').ask('@buffer: ', { submit = true })
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (Buffer)',
      },
      {
        '<leader>oa',
        function()
          require('opencode').ask('@this: ', { submit = true })
        end,
        mode = { 'v' },
        desc = 'Opencode Ask (Selection)',
      },
      {
        '<leader>ob',
        function()
          require('opencode').ask('@buffers: ', { submit = true })
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (All Buffers)',
      },
      {
        '<leader>od',
        function()
          require('opencode').ask('@diagnostics: ', { submit = true })
        end,
        mode = { 'n' },
        desc = 'Opencode Ask (Diagnostics)',
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- server = {
        --   start = function()
        --     local ok = vim.fn.jobstart(
        --       { 'wt.exe', '-w', '0', 'nt', '--title', 'opencode', 'powershell', '-NoExit', 'opencode', '--port' },
        --       { detach = true }
        --     )
        --     if ok <= 0 then
        --       vim.notify('wt.exe not found, starting opencode directly', vim.log.levels.WARN)
        --       vim.fn.jobstart({ 'opencode', '--port' }, { detach = true })
        --     end
        --   end,
        --   stop = function()
        --     vim.fn.jobstart({ 'taskkill', '/f', '/im', 'opencode.exe' }, { detach = true })
        --   end,
        --   toggle = function()
        --     vim.fn.jobstart(
        --       { 'wt.exe', '-w', '0', 'nt', '--title', 'opencode', 'powershell', '-NoExit', 'opencode', '--port' },
        --       { detach = true }
        --     )
        --   end,
        -- },
      }
    end,
  },
}
