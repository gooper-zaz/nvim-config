local img_previewer = {
  'chafa',
  '{file}',
  -- '--format=sixels',
  '-f',
  'sixels',
}

return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'FzfLua',
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {
      previewers = {
        builtin = {
          extensions = {
            ['png'] = img_previewer,
            ['jpg'] = img_previewer,
            ['jpeg'] = img_previewer,
            ['gif'] = img_previewer,
            ['webp'] = img_previewer,
          },
        },
      },
    },
    config = function(_, opts)
      require('fzf-lua').setup(opts)
    end,
  },
}
