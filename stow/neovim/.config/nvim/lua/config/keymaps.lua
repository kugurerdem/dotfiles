-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.api.nvim_set_keymap

-- SoftWrap command
vim.api.nvim_create_user_command("SoftWrap", function()
  vim.wo.wrap = true
  vim.wo.linebreak = true
  vim.o.columns = 80
  print("Wrap and linebreak on; columns set to 80")
end, {})

-- Keymaps
map('n', '<leader>c', ':set cc=80<CR>', {
  noremap = true,
  silent = true,
  desc = 'Show 80-column ruler',
})
map('n', '<leader>C', ':set cc=0<CR>', {
  noremap = true,
  silent = true,
  desc = 'Hide column ruler',
})
map('n', '<leader>n', ':noh<CR>', {
  noremap = true,
  silent = true,
  desc = 'Clear search highlight',
})
