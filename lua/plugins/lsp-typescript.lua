return {
  {
    -- tsserver 替代品, 会有更好的性能表现
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    event = { 'BufReadPost' },
    config = function()
      require('typescript-tools').setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = 'insert_leave',
          tsserver_file_preferences = {
            includeCompletionsForModuleExports = true,

            -- inlay hints
            includeInlayParameterNameHints = 'literals',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
          tsserver_plugins = {
            'typescript-vue-plugin',
          },
        },
      })
    end,
  },
}
