-- # FILETYPES # --
vim.filetype.add({
  extension = {
    dft = "draft"
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.number = false
    vim.opt.colorcolumn = ""

  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

