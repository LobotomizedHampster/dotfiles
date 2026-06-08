-- # PLUGINS # --


local my_items = {
  { text = "Config", path = "~/.config/nvim/init.lua" },
  { text = "Plugins", path = "~/.config/nvim/lua/plugins.lua" },
}

local function my_picker()
  require("snacks").picker({
    items = my_items,
    on_select = function(item)
      vim.cmd("edit " .. item.path)
    end,
  })
end

-- ## LAZY ## --

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- ### LAZY PLUGINS ### ---

local plugins = {
  -- Table plugin
  {
    "Kicamon/markdown-table-mode.nvim",
    config = function()
      require("markdown-table-mode").setup()
    end,
  },

  -- Unicode Completion
  {
    "chrisbra/unicode.vim",
    event = "InsertEnter", -- load on insert mode
    config = function()
      vim.api.nvim_set_keymap(
        'i',                   -- mode: insert
        '<S-tab>',           -- lhs (the key sequence)
        '<Plug>(DigraphComplete)', -- rhs (the mapping target)
        { noremap = false, silent = true } -- options: allow <Plug>, silent
      )
    end
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",  -- New rewritten branch
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local parsers = { 
        "lua", 
        "python", 
        "vim", 
        "vimdoc", 
        "bash", 
        }

        for _, parser in ipairs(parsers) do
          pcall(ts.install, parser)
        end
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            pcall(vim.treesitter.start)
          end,
        })
      end,
    },

    -- Grammer checker
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.lsp.config.ltex = {
          cmd = { "ltex-ls" },
          filetypes = { "markdown", "text", "draft" },
          settings = {
            ltex = {
              language = "en-US",
            },
          },
        }
        vim.lsp.enable("ltex")
      end,
    },

    {
      'nvim-telescope/telescope.nvim', version = '*',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      }
    },

  { -- markdown previews
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 
                   'nvim-mini/mini.icons', 
                   'nvim-tree/nvim-web-devicons' }, 
    opts = {
      enabled = true,
      heading = {
        sign = false,
        icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
        width = 'full', -- either block or full
        --position = 'inline',
        left_pad = 0,
        right_pad  = 1,
        min_width = 30,
      },
      checkbox = {
        unchecked = { icon = '󰄱 ' },
        checked = { icon = '󰡖 ' },
        custom = { todo = { rendered = '󰄗 ' } },
      },
      code = {
        sign = false,
      },
    },
  }
}

  -- Load lazy plugins
  require("lazy").setup(plugins)

  -- ## CUSTOM PLUGINS ## --

  -- checkbox plugin
  vim.keymap.set("n", " ", 
  ":lua require('toggle-checkbox').toggle()<CR>", 
  { silent = true })
  require("toggle-checkbox")
