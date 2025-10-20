-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- SoftWrap command
vim.api.nvim_create_user_command("SoftWrap", function()
  vim.wo.wrap = true
  vim.wo.linebreak = true
  vim.o.columns = 80
  print("Wrap and linebreak on; columns set to 80")
end, {})

-- Keymaps
map('n', '<leader>c', ':set cc=80<CR>', opts)
map('n', '<leader>C', ':set cc=0<CR>', opts)
map('n', '<leader>n', ':noh<CR>', opts)
