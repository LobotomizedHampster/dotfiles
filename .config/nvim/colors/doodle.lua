vim.cmd("highlight clear")
vim.cmd("set termguicolors")

vim.g.colors_name = "doodle"

local set = vim.api.nvim_set_hl

-- PALETTE
local c = {
  bg       = "#161414",
  fg       = "#ebdbc2",
  muted    = "#a89984",
  
  red      = "#b6343d",
  green    = "#74971a",
  yellow   = "#d79921",
  orange   = "#d05d0e",
  purple   = "#b16286",
  pink     = "#d16286",
  cyan     = "#689d8a",
  blue     = "#458588",
  
  hl       = "#3c3836",
}

-- UI
set(0, "Normal",       { fg = c.fg, bg = c.bg })
set(0, "LineNr",       { fg = c.muted, bold = true })
set(0, "Visual",       { bg = c.hl })
set(0, "StatusLine",   { fg = c.bg, bg = c.fg })
set(0, "VertSplit",    { fg = c.fg })

-- SYNTAX
set(0, "Comment",      { fg = c.muted, italic = true })
set(0, "@comment",     { fg = c.muted, italic = true })
set(0, "String",       { fg = c.green })
set(0, "@string",      { fg = c.green })
set(0, "Keyword",      { fg = c.purple, bold = true })
set(0, "@keyword",     { fg = c.purple, bold = true })
set(0, "Function",     { fg = c.red })
set(0, "@function",    { fg = c.red })
set(0, "Type",         { fg = c.yellow })
set(0, "@type",        { fg = c.yellow })
set(0, "Constant",     { fg = c.orange })
set(0, "@constant",    { fg = c.orange })
set(0, "Operator",     { fg = c.cyan })
set(0, "@operator",    { fg = c.cyan }) 
set(0, "@punctuation", { fg = c.fg })
set(0, "@variable",    { fg = c.blue })
set(0, "@property",    { fg = c.pink })
set(0, "PreProc",      { fg = c.pink })
set(0, "ColorColumn",  { fg = c.muted, bg = c.hl })
set(0, "Special",      { fg = c.cyan, bold = true })

-- DIFF DYNTAX

set(0, "Added",      { fg = c.green })

-- DRAFT SYNTAX
set(0, "DraftChapter",    { fg = c.purple, bold = true })
set(0, "DraftBold",       { bold = true })
set(0, "DraftItalic",     { italic = true })
set(0, "DraftBoldItalic", { italic = true, bold = true })
set(0, "DraftEditInsert", { fg = c.green })
set(0, "DraftEditRemove", { fg = c.red })
set(0, "DraftTodo",       { fg = c.yellow, bold = true })
