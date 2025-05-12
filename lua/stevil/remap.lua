vim.g.mapleader = " "
vim.g.maplocalleader = vim.g.mapleader
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

---------------- General keymaps -----------------
vim.keymap.set('', '<leader>h', '<cmd>set hlsearch!<CR>')
vim.keymap.set('', '<F1>', '<cmd>setlocal spell!<CR>')
vim.keymap.set('', '<F2>', '<cmd>setlocal list!<CR>')
vim.keymap.set('', '<F3>', vim.cmd.Ex)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')  -- exit from insert mode on terminal

----------------- Plagins keymaps -----------------
--require('keys/lsp')
-- LSP plugin keymappings
vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR> ')
vim.keymap.set('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<leader>lds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.keymap.set('n', '<leader>lws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>')
vim.keymap.set('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>')
--require('keys/vimspector')

--require('keys/nvim-dap_keys')
--require('keys/telescope')
---------------------------- Telescope keys ----------------------------------
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>')
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
vim.keymap.set('n', '<leader>fe', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fee', '<cmd>Telescope lsp_workspace_diagnostics<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')
vim.keymap.set('n', '<leader>fds', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')


-- Toggle between dark and light colorschems
vim.cmd([[
function! BackgroundToggle()
    if (&background == "dark")
        set background=light
    else
        set background=dark
    endif
endfunction
map <F12> :call BackgroundToggle()<CR>
]])
