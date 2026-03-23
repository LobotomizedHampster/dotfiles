-- # OPTIONS # --

vim.o.linebreak = true -- continue lines at next space
local default_colorcolumn = "81"
vim.opt.colorcolumn = default_colorcolumn -- set a color column
vim.o.number = true -- add line numbers
vim.opt.clipboard = "unnamedplus" -- clipboard is the same as nvim buffer

-- set tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true -- makes tabs spaces instead

-- hide grammar checks
vim.diagnostic.config({
    signs =  false,
    underline = false,
})
