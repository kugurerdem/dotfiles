return {
  -- Completion
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = false },
        },
      },
    },
  },

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

  -- CSS Color Preview
  { 'ap/vim-css-color' },

}
