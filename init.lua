---- Path of the this init.lua ~/.config/nvim/init.lua
---- Path of the file to be cached ~/.local/share/nvim/lazy/lazy.nvim
-- Auto-install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---- Set up the Lazy.nvim plugin manager
--vim.cmd [[packadd lazy.nvim]]


-- Set leader key to space
vim.g.mapleader = " "

-- Function to open a terminal in a floating window
function FloatingTerminal()
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.5)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded'
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, opts)
  vim.cmd('terminal')
  vim.cmd('startinsert')
end

-- Key mapping to open the floating terminal with <leader>t (Space + t)
vim.api.nvim_set_keymap('n', '<leader>t', ':lua FloatingTerminal()<CR>', { noremap = true, silent = true })



require("lazy").setup({
  -- Gruvbox theme configuration
  {
    "morhetz/gruvbox",  -- Gruvbox color scheme plugin
    config = function()
      vim.o.background = "dark"  -- Use the dark theme variant
      vim.cmd("colorscheme gruvbox")  -- Set Gruvbox as the colorscheme
    end,
  },

  -- Noice.nvim for command center, notifications, and other UI enhancements
  {
    "folke/noice.nvim",
    dependencies = { 
      "MunifTanjim/nui.nvim",       -- UI components for Noice
      "rcarriga/nvim-notify"        -- Notification backend for Noice
    },
    config = function()
      require("noice").setup({
        -- Centered command line popup settings
        cmdline = {
          enabled = true,
          view = "cmdline_popup",  -- Display the command line in the center as a popup
          format = {
            cmdline = { icon = ">" } -- Custom icon for command line
          }
        },
        
        -- Message settings to use nvim-notify for enhanced notifications
        messages = {
          enabled = true,
          view = "notify",            -- Show all messages through nvim-notify
          view_error = "notify",      -- Show errors in notify popup
          view_warn = "notify",       -- Show warnings in notify popup
          view_history = "messages",  -- Retain message history in messages view
        },

        -- Enabling the nvim-notify backend for notifications
        notify = {
          enabled = true,
        },

        -- Views configuration for nvim-notify and command popup customization
        views = {
          notify = {
            backend = "notify",       -- Use nvim-notify for handling notifications
          },
          cmdline_popup = {
            position = {
              row = "50%",            -- Center the cmdline vertically
              col = "50%",            -- Center the cmdline horizontally
            },
            size = {
              width = 60,             -- Set width for cmdline popup
              height = "auto",        -- Auto height for cmdline
            },
            border = {
              style = "rounded",      -- Rounded border for cmdline popup
            },
          },
        },

        -- Presets for long messages, incremental rename, and LSP doc borders
        presets = {
          long_message_to_split = true,   -- Show long messages in split
          inc_rename = true,              -- Enable incremental renaming UI
          lsp_doc_border = true,          -- Border around LSP documentation
        },
        
        -- Enabling LSP progress messages and overrides for better integration
        lsp = {
          progress = { enabled = true }, -- Show LSP progress messages
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      })
    end,
  },

  -- Lualine for a customized status line that shows the current mode
  {
    "nvim-lualine/lualine.nvim",  -- Lightweight status line plugin
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",         -- Use Gruvbox theme for status line
          section_separators = "",   -- No separators for a cleaner look
          component_separators = "", -- No separators for a cleaner look
        },
        sections = {
          lualine_a = {"mode"},      -- Show current mode in section 'a'
          lualine_b = {"branch"},    -- Git branch
          lualine_c = {"filename"},  -- File name
          lualine_x = {"encoding", "fileformat", "filetype"}, -- File details
          lualine_y = {"progress"},  -- Progress in the file
          lualine_z = {"location"},  -- Cursor position
        },
      })
    end,
  },

-----Testing Plugins
  -- barbar.nvim setup
  {
    "romgrk/barbar.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Adds icons for file types
    },
    config = function()
      vim.g.bufferline = {
        animation = true, -- Enable smooth animations
        auto_hide = false, -- Always show the bufferline
        tabpages = true, -- Include tabpages in the bufferline
        icons = "both", -- Show both icons and buffer numbers
        maximum_padding = 2,
        icon_separator_active = "▎",
        icon_separator_inactive = "▎",
      }
    end,
  },
  
  -- nvim-web-devicons for icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
          },
        },
        default = true,
      })
    end,
  },

})

----Keybindings for moving between buffers
vim.api.nvim_set_keymap("n", "<leader>l", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", { noremap = true, silent = true })

-- General Settings
vim.o.number = true                -- Enable absolute line numbers
vim.o.relativenumber = true        -- Enable relative line numbers
vim.o.termguicolors = true         -- Enable 24-bit RGB colors in the terminal
vim.o.mouse = "a"                  -- Enable mouse support in all modes
vim.o.clipboard = "unnamedplus"    -- Use system clipboard for copy/paste
vim.o.showmode = false             -- Disable built-in mode display (handled by lualine)
vim.o.cmdheight = 2                -- More space for displaying messages in the command line

-- Key mappings for enhanced usability
vim.g.mapleader = " "              -- Set leader key to space for custom mappings

-- Additional helpful settings
vim.o.ignorecase = true            -- Ignore case when searching...
vim.o.smartcase = true             -- ... unless uppercase letters are used
vim.o.expandtab = true             -- Use spaces instead of tabs
vim.o.shiftwidth = 4               -- Indent by 4 spaces for each level
vim.o.tabstop = 4                  -- Use 4 spaces for a tab
vim.o.smartindent = true           -- Enable smart indentation

-- Additional appearance tweaks
vim.o.cursorline = true            -- Highlight the current line
vim.o.scrolloff = 8                -- Keep 8 lines above and below the cursor when scrolling
vim.o.sidescrolloff = 8            -- Keep 8 columns to the left and right of the cursor
vim.o.wrap = true                 -- Disable line wrapping

-- Finalize and reload settings
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerSync]])  -- Automatically reloads config on save

