return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
        vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
        vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>')
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>')
        vim.keymap.set('n', '<leader>fc', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
        vim.keymap.set('n', '<leader>fe', '<cmd>Telescope diagnostics<cr>')
        vim.keymap.set('n', '<leader>fee', '<cmd>Telescope lsp_workspace_diagnostics<cr>')
        vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')
        vim.keymap.set('n', '<leader>fds', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')
    end
}

