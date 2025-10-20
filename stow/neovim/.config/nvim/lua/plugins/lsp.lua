return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('mason').setup()
    -- Diagnostics config
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Default LSP settings
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      local keymap = vim.keymap.set
      keymap('n', 'gd', vim.lsp.buf.definition, opts)
      keymap('n', 'gD', vim.lsp.buf.declaration, opts)
      keymap('n', 'K', vim.lsp.buf.hover, opts)
      keymap('n', 'gi', vim.lsp.buf.implementation, opts)
      keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
      keymap('n', 'gr', vim.lsp.buf.references, opts)
      keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      keymap('n', '[d', vim.diagnostic.goto_prev, opts)
      keymap('n', ']d', vim.diagnostic.goto_next, opts)
      keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
      keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)
    end

    vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" }}}}})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = on_attach,
    })

    require('mason-lspconfig').setup {
      ensure_installed = { 'lua_ls', 'gopls' },
      automatic_installation = true,
      automatic_enable = true,
    }
  end
}
