
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",    -- formater plugin
        "williamboman/mason.nvim",  -- external tools installation manager
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim", -- UI for notifications and LSP progress messages
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        --local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ruff",
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git",
                            "build.zig", "zls.json", "compile_commands.json",
                            ".venv", "env"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0

                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe",
                                        "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["ruff"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ruff.setup {
                        capabilities = capabilities,
                        init_options = {
                          settings = {
                            -- Server settings should go here
                          }
                        }
                    }
                end,
            }
        })

        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
