function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
  "akinsho/toggleterm.nvim",
  keys = {
    "<c-\\>",
    {
      "<leader>g",
      -- toggle git bash
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local git = Terminal:new({
          cmd = "E:\\Git\\bin\\bash.exe -s",
          hidden = true,
          on_open = function(term)
            vim.api.nvim_buf_set_keymap(
              term.bufnr,
              "n",
              "<leader>q",
              "<cmd>close<CR>",
              { noremap = true, silent = true }
            )
          end,
        })
        git:toggle()
      end,
      { "n", "v" },
      {
        noremap = true,
        silent = true,
      },
    },
    {
      "<leader>n",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local node = Terminal:new({
          cmd = "node",
          hidden = true,
          on_open = function(term)
            vim.api.nvim_buf_set_keymap(
              term.bufnr,
              "n",
              "<leader>q",
              "<cmd>close<CR>",
              { noremap = true, silent = true }
            )
          end,
        })
        node:toggle()
      end,
      { "n", "v" },
      {
        noremap = true,
        silent = true,
      },
    },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      direction = "float",
      insert_mappings = false,
      shell = "powershell", -- use `powershell` as default shell.
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
    })
  end,
}
