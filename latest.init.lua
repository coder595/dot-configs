---- Path of this init.lua: ~/.config/nvim/init.lua
---- lazy.nvim cache dir:  ~/.local/share/nvim/lazy/lazy.nvim

-- Bootstrap lazy.nvim ---------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader ----------------------------------------------------------------------
vim.g.mapleader = " "

-- Floating terminal -----------------------------------------------------------
local function FloatingTerminal()
  local width  = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines   * 0.5)
  local row    = math.floor((vim.o.lines   - height) / 2)
  local col    = math.floor((vim.o.columns - width)  / 2)

  local opts = {
    relative = "editor",
    width = width, height = height, row = row, col = col,
    style = "minimal", border = "rounded"
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Nice defaults inside the terminal window
  vim.bo[buf].bufhidden = "wipe"
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false

  vim.cmd("terminal")
  vim.cmd("startinsert")
end
vim.keymap.set("n", "<leader>t", FloatingTerminal, { desc = "Floating terminal" })

-- Plugins ---------------------------------------------------------------------
require("lazy").setup({
  -- Theme: Gruvbox (works, but consider ellisonleao/gruvbox.nvim for Lua-native)
  {
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_transparent_bg = 1
      vim.g.gruvbox_bold = 1
      vim.g.gruvbox_italic = 1
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- UI: noice + notify --------------------------------------------------------
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      -- make notify the default message handler
      vim.notify = require("notify")

      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = { cmdline = { icon = ">" } },
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn  = "notify",
          view_history = "messages",
        },
        notify = { enabled = true },
        views = {
          notify = { backend = "notify" },
          cmdline_popup = {
            position = { row = "50%", col = "50%" },
            size = { width = 60, height = "auto" },
            border = { style = "rounded" },
          },
        },
        presets = {
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
        lsp = {
          progress = { enabled = true },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      })
    end,
  },

  -- Statusline: lualine -------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = {
            normal  = { a = { fg="#282828", bg="#d79921", gui="bold" }, b = { fg="#ebdbb2", bg="#504945" }, c = { fg="#ebdbb2", bg="#282828" }, },
            insert  = { a = { fg="#282828", bg="#b8bb26", gui="bold" }, },
            visual  = { a = { fg="#282828", bg="#d3869b", gui="bold" }, },
            replace = { a = { fg="#282828", bg="#fb4934", gui="bold" }, },
            command = { a = { fg="#282828", bg="#689d6a", gui="bold" }, },
            inactive= { a = { fg="#a89984", bg="#282828" }, b = { fg="#a89984", bg="#282828" }, c = { fg="#a89984", bg="#282828" }, },
          },
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Bufferline: barbar (modern setup) -----------------------------------------
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require("barbar").setup({
        animation = true,
        auto_hide = false,
        tabpages = true,
        icons = {
          buffer_index = true,
          filetype = { enabled = true },
          separator = { left = "▎", right = "" },
          inactive = { separator = { left = "▎", right = "" } },
        },
        maximum_padding = 2,
      })
    end,
  },

  -- Devicons ------------------------------------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          zsh = { icon = "", color = "#428850", cterm_color = "65", name = "Zsh" },
        },
        default = true,
      })
    end,
  },

  -- Indent guides (modern) ----------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = true, show_end = false },
      exclude = { filetypes = { "help", "dashboard", "lazy", "NvimTree" } },
    },
  },

  -- Completion: nvim-cmp + vsnip ---------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer"  },
          { name = "vsnip"   },
        },
      })
    end,
  },

  -- Autopairs (TS-aware; add treesitter below) --------------------------------
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- requires treesitter to be effective
        fast_wrap = {
          map = "<M-e>",
          chars = { "(", "[", "{", '"', "'" },
        },
      })
    end,
  },

  -- File explorer: keep NERDTree (legacy) OR switch to nvim-tree --------------
  -- Keep this block if you want to stay with NERDTree:
  -- {
  --   "preservim/nerdtree",
  --   config = function()
  --     vim.keymap.set("n", "<leader>n", ":NERDTreeToggle<CR>", { silent = true, desc = "NERDTree" })
  --     vim.cmd([[
  --       autocmd VimEnter * if !argc() | NERDTree | endif
  --     ]])
  --     vim.g.NERDTreeQuitOnOpen = 1
  --     vim.cmd("highlight NERDTreeDir  ctermfg=108 guifg=#83a598")
  --     vim.cmd("highlight NERDTreeFile ctermfg=251 guifg=#ebdbb2")
  --   end,
  -- },

  -- Recommended alternative (drop-in replacement): nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 32 },
        renderer = { highlight_git = true },
        filters = { dotfiles = false },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "File Explorer" })
    end,
  },

  -- Treesitter (recommended so autopairs/noice markdown/etc. work best) -------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline", "json" },
        highlight = { enable = true },
        indent    = { enable = true },
      })
    end,
  },

------Test--------

    -- Commentary.lua
{
  "tpope/vim-commentary",
  -- no setup function needed, it just works out of the box
},

-- Dashboard: alpha-nvim -------------------------------------------------------
-----Icons according to Firacode icons-------

{
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header with NEOVIM in bold italic (ASCII)
    dashboard.section.header.val = {
      "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "              𝐍𝐄𝐎𝐕𝐈𝐌  𝑩𝑶𝑳𝑫 𝑰𝑻𝑨𝑳𝑰𝑪          ",
    }

    -- Buttons with Nerd Font compatible icons
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New File", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
    }

    -- Footer
    dashboard.section.footer.val = "󱠇  Happy coding in NEOVIM!"

    dashboard.config.opts.noautocmd = true
    alpha.setup(dashboard.config)
  end,
},


-- Telescope -------------------------------------------------------------------

{
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        prompt_prefix = "󰍉 ",
        selection_caret = " ",
        entry_prefix = "  ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
          width = 0.9,
          height = 0.85,
        },
        mappings = {
          i = {
            ["<C-k>"] = "move_selection_previous",
            ["<C-j>"] = "move_selection_next",
            ["<C-q>"] = "close",
          },
        },
      },
    })

    -- Keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help Tags" })

    -- Gruvbox highlight overrides
    vim.cmd([[
      highlight TelescopeNormal guibg=#282828 guifg=#ebdbb2
      highlight TelescopeBorder guibg=#282828 guifg=#504945
      highlight TelescopePromptNormal guibg=#3c3836 guifg=#ebdbb2
      highlight TelescopePromptBorder guibg=#3c3836 guifg=#504945
      highlight TelescopePromptTitle guibg=#d79921 guifg=#282828 gui=bold
      highlight TelescopeResultsTitle guibg=#b16286 guifg=#282828 gui=bold
      highlight TelescopeSelection guibg=#504945 guifg=#fabd2f
    ]])
  end,
},


----------------
})


-- Keymaps: barbar buffers -----------------------------------------------------
vim.keymap.set("n", "<leader>l", "<cmd>BufferNext<CR>",     { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>h", "<cmd>BufferPrevious<CR>", { silent = true, desc = "Prev buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>BufferClose<CR>",    { silent = true, desc = "Close buffer" })

-- Tabs ------------------------------------------------------------------------
vim.keymap.set("n", "<leader>te", ":tabedit ", { silent = false, desc = "New tab (type filename)" })

-- General settings ------------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.showmode = false
-- For noice: consider 0 to hide the command line space.
vim.o.cmdheight = 0

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true

vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = true

-- Reload on save (lazy.nvim, not packer) -------------------------------------
-- Re-source init.lua after saving. Trigger a lightweight Lazy check.
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "init.lua",
  callback = function()
    vim.cmd("source " .. vim.fn.expand("<afile>"))
    -- Do a quick check for plugin spec changes (fast). Use :Lazy sync manually when you add/remove a lot.
    pcall(function() require("lazy").check() end)
  end,
})
