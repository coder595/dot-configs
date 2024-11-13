-- init.lua
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Enable line numbers
vim.opt.number = true        -- Show absolute line numbers on the current line
vim.opt.relativenumber = true -- Show relative line numbers on all other lines

require("lazy").setup({
  -- Gruvbox theme plugin
  {
    "morhetz/gruvbox",
    config = function()
      -- Set Gruvbox dark theme
      vim.cmd("colorscheme gruvbox")
      vim.opt.background = "dark"  -- Set background to dark (for gruvbox dark theme)
    end
  },
  -- CMD Line on th center
    {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline_popup",  -- Show command line at the top
          format = {
            cmdline = { icon = ">" }
          }
        }
      })
    end
  },
  -- Other plugins can be added here
})

-- Enable 24-bit RGB color in terminal for accurate color rendering
vim.o.termguicolors = true

-- Enable mouse support in all modes
vim.o.mouse = 'a'

-- Use system clipboard for copy-paste
vim.o.clipboard = 'unnamedplus'


-- Other general settings can be added below as needed
