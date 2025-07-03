return {
    'jakewvincent/mkdnflow.nvim',
    config = function()
        require('mkdnflow').setup({
            perspective = {
                priority = 'root',
                fallback = 'current',
                root_tell = 'index.md',
            },
        })
    end
}
