-- # NVIM CONFIG # --

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
            "markdown", 
            "rust" }
  
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
  }
}

-- Load plugins
require("lazy").setup(plugins)



-- ## SETTINGS ## ---

-- ### CUSTOM PLUGINS ### --

-- checkbox plugin
vim.keymap.set("n", " ", 
    ":lua require('toggle-checkbox').toggle()<CR>", 
    { silent = true })
    require("toggle-checkbox")


-- ### OPTIONS ### --

vim.o.linebreak = true -- continue lines at next space
local default_colorcolumn = "81"
vim.opt.colorcolumn = default_colorcolumn -- set a color column
-- set tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true -- makes tabs spaces instead

vim.o.number = true -- add line numbers
vim.opt.clipboard = "unnamedplus" -- clipboard is the same as nvim buffer
-- hide grammar checks
vim.diagnostic.config({
    signs =  false,
    underline = false,
})



-- ### COMMANDS ### -- 

-- Settings for writing
local writing_enabled = false -- disable writing cmd by default 
vim.api.nvim_create_user_command("Wr", function()
    writing_enabled = not writing_enabled

    if writing_enabled then
        -- options
        vim.opt.linebreak = true
        vim.opt.breakindent = true
        vim.opt.spell = true
        vim.o.number = false -- disable line numbers
        vim.opt.colorcolumn = "" -- disable color column

        -- keymaps
        vim.keymap.set('n', 'j', 'gj')
        vim.keymap.set('n', 'k', 'gk')
        vim.keymap.set('n', '<Up>', 'gk')
        vim.keymap.set('n', '<Down>', 'gj')
        vim.keymap.set('n', '<ScrollWheelUp>', '3gk')
        vim.keymap.set('n', '<ScrollWheelDown>', '3gj')
        vim.keymap.set('n', '<Return>', 'z=')

        print("Writing ON")
    else
        -- reset options
        vim.opt.linebreak = not vim.opt.linebreak
        vim.opt.breakindent = not vim.opt.breakindent
        vim.o.number = not vim.o.number
        vim.opt.colorcolumn = default_colorcolumn

        -- delete keymaps
        vim.keymap.del('n', 'j')
        vim.keymap.del('n', 'k')
        vim.keymap.del('n', '<Up>')
        vim.keymap.del('n', '<Down>')
        vim.keymap.del('n', '<ScrollWheelUp>')
        vim.keymap.del('n', '<ScrollWheelDown>')
        vim.keymap.del('n', '<Return>')

        print("Writing OFF")
    end
end, {})

local editing_enabled = false
vim.api.nvim_create_user_command("Ed", function()
    editing_enabled = not editing_enabled

    vim.diagnostic.config({
        signs = editing_enabled,
        underline = editing_enabled,
    })

    if editing_enabled then
        -- options
        vim.opt.spell = true

        -- keymaps
        vim.keymap.set('n', 'z+', function()
            vim.diagnostic.open_float()
        end)

        print("Editing ON")
    else
        -- reset options
        vim.opt.spell = not vim.opt.spell
        vim.cmd("LspStop")

        -- delete keymaps
        vim.keymap.del('n', 'z+')

        print("Writing OFF")
    end
end, {})



-- ### KEYBINDS ### --

-- open nvim config files in a split window
vim.api.nvim_create_user_command("EditConfig", function()
    vim.cmd.split(vim.fn.stdpath("config"))
end, {})

-- Set ctrl + c to copy text
vim.keymap.set("v", "<C-c>", "\"+y",  { noremap = true, silent = true })
-- Set ctrl + x to cut text
vim.keymap.set("v", "<C-x>", "d",  { noremap = true, silent = true })


-- ### OPTIONS ### --

vim.o.linebreak = true -- continue lines at next space
vim.opt.colorcolumn = "81" -- set a color column
-- set tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true -- makes tabs spaces instead

vim.o.number = true -- Add numbers to side
vim.opt.clipboard = "unnamedplus" -- clipboard is the same as nvim buffer


-- ### OTHER THINGS ### --

require("filetypes") -- Custom syntax highlighting for drafts
vim.cmd.colorscheme("doodle") -- set color scheme
