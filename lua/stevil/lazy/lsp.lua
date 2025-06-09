-- language server protocol

return {
  "neovim/nvim-lspconfig",

  dependencies = {
    --"williamboman/mason.nvim",
    "hrsh7th/nvim-cmp",
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },

  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    --local mason = require("mason")
    --mason.setup()

    -- Lua LSP
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';')
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },

    })

    -- Python LSP
    lspconfig.pylsp.setup{
        capabilities = capabilities,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { maxLineLength = 160 },
                    --jedi_completion = {cache_for = ""}
                }
            }
        }
    }

    -- C\C++ LSP
    lspconfig.clangd.setup{
        capabilities = capabilities,
        cmd = {
            "clangd",
        }
    }
    -- ...
  end,
}
