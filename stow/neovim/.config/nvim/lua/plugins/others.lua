return {
  -- Autopairs
  { 'windwp/nvim-autopairs', config = function()
      require('nvim-autopairs').setup({})
    end
  },

  -- Vim Surround
  { 'tpope/vim-surround' },

  -- Markdown Preview
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },

  -- Treesitter Autotag
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },

  -- CSS Color Preview
  { 'ap/vim-css-color' },

}
