return {
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    event = 'VeryLazy',
    opts = {
      lsp = {
        hover = { silent = true },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    config = function(_, opts)
      require('noice').setup(opts)

      -- hover doc scroll keymaps
      vim.keymap.set({ 'n', 'i', 's' }, '<c-f>', function()
        if not require('noice.lsp').scroll(4) then
          return '<c-f>'
        end
      end, { silent = true, expr = true })

      vim.keymap.set({ 'n', 'i', 's' }, '<c-b>', function()
        if not require('noice.lsp').scroll(-4) then
          return '<c-b>'
        end
      end, { silent = true, expr = true })

      vim.keymap.set('n', '<leader>cr', function()
        -- 如果当前filetype是'vue', 则使用vim内置的rename行为
        if vim.bo.filetype == 'vue' then
          return ':lua vim.lsp.buf.rename()<CR>'
        end
        local inc = require('inc_rename')
        return ':' .. inc.config.cmd_name .. ' ' .. vim.fn.expand('<cword>')
      end, { expr = true })
    end,
  },
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    opts = {},
  },
}
