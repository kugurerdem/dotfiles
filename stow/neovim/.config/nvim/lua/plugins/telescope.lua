return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local action_layout = require('telescope.actions.layout')

    telescope.setup({
      defaults = {
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'top',
          width = 0.9,
          height = 0.8,
          horizontal = {
            preview_width = 0.55,
          },
        },
        mappings = {
          i = {
            ['<Esc>'] = actions.close,
            ['<C-c>'] = actions.close,
            ['<Tab>'] = actions.move_selection_next,
            ['<S-Tab>'] = actions.move_selection_previous,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.results_scrolling_up,
            ['<C-d>'] = actions.results_scrolling_down,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = action_layout.toggle_preview,
          },
          n = {
            ['<Esc>'] = actions.close,
            ['<C-c>'] = actions.close,
            ['<Tab>'] = actions.move_selection_next,
            ['<S-Tab>'] = actions.move_selection_previous,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.results_scrolling_up,
            ['<C-d>'] = actions.results_scrolling_down,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = action_layout.toggle_preview,
          },
        },
      },
    })

    local function supports_lsp_method(method)
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client:supports_method(method, 0) then
          return true
        end
      end

      return false
    end

    local function workspace_root()
      local buffer_path = vim.api.nvim_buf_get_name(0)
      local roots = {}

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        local root = client.root_dir or client.config.root_dir
        if root and (buffer_path == '' or vim.fs.relpath(root, buffer_path)) then
          table.insert(roots, root)
        end
      end

      table.sort(roots, function(left, right)
        return #left > #right
      end)

      return roots[1] or vim.fn.getcwd()
    end

    local function symbol_picker_options()
      return {
        symbol_width = 50,
        fname_width = 24,
        layout_config = {
          width = 0.95,
          horizontal = {
            preview_width = 0.35,
          },
        },
      }
    end

    local function document_symbols()
      if supports_lsp_method('textDocument/documentSymbol') then
        builtin.lsp_document_symbols(symbol_picker_options())
        return
      end

      if pcall(vim.treesitter.get_parser, 0) then
        builtin.treesitter(symbol_picker_options())
        return
      end

      vim.notify('Document symbols require an LSP or Tree-sitter parser', vim.log.levels.INFO)
    end

    local function workspace_symbols()
      if not supports_lsp_method('workspace/symbol') then
        vim.notify('Workspace symbols require an attached LSP that supports workspace symbols', vim.log.levels.INFO)
        return
      end

      builtin.lsp_dynamic_workspace_symbols(symbol_picker_options())
    end

    local function workspace_diagnostics()
      if supports_lsp_method('workspace/diagnostic') then
        local request_finished = false
        local autocmd = vim.api.nvim_create_autocmd('LspRequest', {
          callback = function(event)
            local request = event.data.request
            if request.method == 'workspace/diagnostic' and request.type == 'complete' then
              request_finished = true
              return true
            end
          end,
        })

        vim.lsp.buf.workspace_diagnostics()
        vim.wait(1000, function()
          return request_finished
        end)

        if not request_finished then
          vim.api.nvim_del_autocmd(autocmd)
        end
      end

      builtin.diagnostics({
        root_dir = workspace_root(),
      })
    end

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files({ cwd = workspace_root() })
    end, { desc = '[S]earch Workspace [F]iles' })
    vim.keymap.set('n', '<leader>sF', builtin.find_files, { desc = '[S]earch CWD [F]iles' })
    vim.keymap.set('n', '<leader>ss', document_symbols, { desc = '[S]earch Document [S]ymbols' })
    vim.keymap.set('n', '<leader>sS', workspace_symbols, { desc = '[S]earch Workspace [S]ymbols' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch Current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = '[S]earch Document [D]iagnostics' })
    vim.keymap.set('n', '<leader>sD', workspace_diagnostics, { desc = '[S]earch Workspace [D]iagnostics' })
    vim.keymap.set('n', '<leader>sj', builtin.jumplist, { desc = '[S]earch [J]umplist' })
    vim.keymap.set('n', '<leader>sc', builtin.git_status, { desc = '[S]earch Git [C]hanges' })
    vim.keymap.set('n', '<leader>s/', builtin.current_buffer_fuzzy_find, { desc = '[S]earch Current Buffer' })
    vim.keymap.set('n', '<leader>s:', builtin.command_history, { desc = '[S]earch Command History' })
    vim.keymap.set('n', '<leader>s?', builtin.builtin, { desc = '[S]earch Picker Catalog' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find Existing Buffers' })
  end,
}
