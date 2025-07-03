vim.g.mapleader = " "
vim.g.maplocalleader = vim.g.mapleader
local map = vim.keymap.set

map("n", "<leader>e", vim.cmd.Ex)

---------------- General keymaps -----------------
map('', '<leader>h', '<cmd>set hlsearch!<CR>')
map('', '<F1>', '<cmd>setlocal spell!<CR>')
map('', '<F2>', '<cmd>setlocal list!<CR>')
map('', '<F3>', vim.cmd.Ex)
map('t', '<Esc>', '<C-\\><C-n>')  -- exit from insert mode on terminal

----------------- Plagins keymaps -----------------
--require('keys/lsp')
-- LSP plugin keymappings
map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR> ')
map('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<leader>lds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', '<leader>lws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>')
map('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Open my wiki (replace vimwiki by mkdnflow)
map('n', '<leader>ww', '<cmd>tabnew ~/notes/index.md<CR>')
--require('keys/vimspector')
--require('keys/nvim-dap_keys')
--require('keys/telescope')
---------------------------- Telescope keys ----------------------------------
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fk', '<cmd>Telescope keymaps<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>fs', '<cmd>Telescope spell_suggest<cr>')
map('n', '<leader>fc', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
map('n', '<leader>fe', '<cmd>Telescope diagnostics<cr>')
map('n', '<leader>fee', '<cmd>Telescope lsp_workspace_diagnostics<cr>')
map('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>')
map('n', '<leader>fds', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>')


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
