-- StEvil's config for lualine --

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    readonly = function()         return vim.opt.readonly:get()     end,
    modified = function()         return vim.opt.modified:get()     end,
}

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require'lualine'.setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = {left = '', right = ''},
                section_separators = {left = '', right = ''},
                disabled_filetypes = {}
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    { -- Readonly sign
                        function() return '' end,
                        cond = conditions.readonly,
                        color = {fg='#FF5F67'}, -- red
                        component_separators = '',
                        padding = {left = 1, right=0}
                    },
                    {'filename', file_status=false, component_separators = ''},
                    { -- Modefied sign
                        function() return '🮙' end,
                        cond = conditions.modified,
                        color = {fg='#FF8800'}, -- orange
                        component_separators = '',
                        padding = {left = 0, right=1}
                    },
                },
                lualine_c = {'branch', {'diff', cond=conditions.hide_in_width}},
                lualine_x = {
                    {'encoding', cond=conditions.hide_in_width},
                    {'fileformat', cond=conditions.hide_in_width},
                    {'filetype', icon_only=true, cond=conditions.hide_in_width},
                },
                lualine_y = {
                    {
                        'diagnostics',
                        sources = {'nvim_diagnostic'},
                        sections = {'error', 'warn', 'info', 'hint'},
                        symbols = { error = ' ', warn = ' ', info = ' ' },
                        update_in_insert = false,
                    }
                },
                lualine_z = {
                    'progress',
                    '%l/%L:%c', -- location as vim's statusline variables
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {
                    { -- Readonly sign
                        function() return '' end,
                        cond = conditions.readonly,
                        component_separators = '',
                        padding = {left = 1, right=0}
                    },
                    {'filename', file_status=false, component_separators = ''},
                    { -- Modefied sign
                        function() return '🮙' end,
                        cond = conditions.modified,
                        component_separators = '',
                        padding = {left = 0, right=1}
                    },
                },
                lualine_c = {},
                lualine_x = {'%l/%L:%c'}, -- location as vim's statusline variables
                lualine_y = {},
                lualine_z = {}
            },
        --    tabline = {
        --        lualine_a = {{'tabs', mode = 2}},
        --        lualine_z = {{'buffers', show_modified_status = true}}
        --    },
        }

    end
}
