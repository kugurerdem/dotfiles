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
    local on_attach = function(event)
      local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
      local opts = { noremap = true, silent = true, buffer = event.buf }
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

      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, event.buf, {
          autotrigger = true,
        })

        local function completion_key(menu_key, fallback)
          return function()
            if vim.fn.pumvisible() == 1 then
              return menu_key
            end
            return type(fallback) == 'function' and fallback() or fallback
          end
        end

        local completion_opts = { buffer = event.buf, expr = true, silent = true }
        keymap('i', '<CR>', function()
          local menu_visible = vim.fn.pumvisible() == 1
          local item_selected = vim.fn.complete_info({ 'selected' }).selected ~= -1

          if menu_visible and item_selected then
            return '<C-y>'
          end

          local newline = require('nvim-autopairs').autopairs_cr()
          return menu_visible and '<C-e>' .. newline or newline
        end, completion_opts)
        keymap('i', '<C-c>', completion_key('<C-e>', '<C-c>'), completion_opts)
        keymap('i', '<Tab>', completion_key('<C-n>', function()
          if vim.snippet.active({ direction = 1 }) then
            return '<Cmd>lua vim.snippet.jump(1)<CR>'
          end
          return vim.fn['copilot#Accept']()
        end), completion_opts)
        keymap('i', '<S-Tab>', completion_key('<C-p>', function()
          if vim.snippet.active({ direction = -1 }) then
            return '<Cmd>lua vim.snippet.jump(-1)<CR>'
          end
          return '<S-Tab>'
        end), completion_opts)
      end
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
