-- colorscheme = function ()
--   require("carbonfox")
--
-- end
return {
  {
    "EdenEast/nightfox.nvim",
    "rebelot/kanagawa.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    opts = {
      flavor = "mocha",
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      },
      highlight_overrides = {
        all = function(mocha)
          return {
            LineNrAbove = { fg = mocha.overlay0 },
            CursorLineNr = { fg = mocha.green },
            LineNrBelow = { fg = mocha.overlay0 },
          }
        end,
      },
      -- custom_highlights = function(colors)
      --   local u = require("catppuccin.utils.colors")
      --
      --   return {
      --     CursorLine = {
      --       -- bg = u.darken(colors.surface0, 0.14, colors.base),
      --       -- bg = colors.mantle,
      --       bg = "None",
      --     },
      --   }
      -- end,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true },
        },
      },
      explorer = {
        hidden = true, -- Show dotfiles in the explorer
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        autopep8 = {},
        clangd = {},
        clang_format = {},
        codelldb = {},
        cpptools = {},
        debugpy = {},
        pyright = {},
        rust_analyzer = {},
      },
    },
  },
}
