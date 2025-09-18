return {
    'HiPhish/info.vim',
    config = function()
        --local inf = require("info.vim")
        vim.keymap.set('n', '<leader>iu', '<cmd>InfoUp<CR> ', { desc = "Info Up" })
        vim.keymap.set('n', '<leader>in', '<cmd>InfoNext<CR> ', { desc = "Info Next" })
        vim.keymap.set('n', '<leader>ip', '<cmd>InfoPrev<CR> ', { desc = "Info Previous" })
    end
}

