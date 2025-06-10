return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 999 },
  { "sainnhe/gruvbox-material", name = "gruvbox", priority = 998,
      config = function()
        vim.g.gruvbox_material_background = 'medium'
        vim.g.gruvbox_material_foreground = 'mix'
        vim.g.gruvbox_material_better_performance = true
        vim.g.gruvbox_material_enable_bold = true
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme('gruvbox-material')
      end
    },
}
