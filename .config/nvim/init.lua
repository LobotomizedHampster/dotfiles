-- # NVIM CONFIG # --

-- ## FILES ## --

require("user.commands")  -- custom commands and keybinds
require("user.packages")  -- package manager and packages
require("user.options")   -- default options
require("user.filetypes") -- Custom syntax highlighting for drafts (.dft)

-- custom plugin (for testing)
require("math_editor").hello()

vim.cmd.colorscheme("doodle") -- set color scheme
