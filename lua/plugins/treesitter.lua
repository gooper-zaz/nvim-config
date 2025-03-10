return {
 {
   'nvim-treesitter/nvim-treesitter',
   event = 'VeryLazy',
   opts_extend = { 'ensure_installed' },
   opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      'vim',
      'vimdoc',
      'regex',
      'lua',
      'luadoc',
      'bash',
      'markdown',
      'markdown_inline',
      'html',
      'css',
      'json',
      'yaml',
    },
   },
   config = function(_, opts)
     require('nvim-treesitter.configs').setup(opts)
   end,
 }
}
