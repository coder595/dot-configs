---- Path of the file ~/.config/nvim/init.lua
-- init.lua
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Enable line numbers
vim.opt.number = true        -- Show absolute line numbers on the current line
vim.opt.relativenumber = true -- Show relative line numbers on all other lines

require("lazy").setup({
  -- Add plugins here
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
})

