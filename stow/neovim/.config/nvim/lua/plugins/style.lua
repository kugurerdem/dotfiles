return {
  -- Airline
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },
    config = function()
      vim.g.airline_theme = 'catppuccin'
      vim.g.airline_powerline_fonts = 1
    end
  },

  -- Catpuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'macchiato', -- latte, frappe, macchiato, mocha
        transparent_background = true,
        term_colors = true,
      })
      vim.cmd.colorscheme('catppuccin')
    end
  },
}
