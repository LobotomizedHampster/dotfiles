-- # COMMANDS # -- 

-- open nvim config files in a split window
vim.api.nvim_create_user_command("EditConfig", function()
    vim.cmd.split(vim.fn.stdpath("config"))
end, {})

-- # KEYBINDS # --

-- Set ctrl + c to copy text
vim.keymap.set("v", "<C-c>", "\"+y",  { noremap = true, silent = true })
-- Set ctrl + x to cut text
vim.keymap.set("v", "<C-x>", "d",  { noremap = true, silent = true })

-- Change window size
vim.keymap.set("n", "<C-H>", "<C-w><",  { noremap = true, silent = true })
vim.keymap.set("n", "<C-J>", "<C-w>-",  { noremap = true, silent = true })
vim.keymap.set("n", "<C-K>", "<C-w>+",  { noremap = true, silent = true })
vim.keymap.set("n", "<C-L>", "<C-w>>",  { noremap = true, silent = true })
