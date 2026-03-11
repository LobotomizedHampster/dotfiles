vim.cmd([[
syntax region DraftChapter start=/\v#{1,5} / end=/\v #{1,5}/

syntax region DraftBold start=/\*\*/ end=/\*\*/
syntax region DraftBoldItalic start=/\*_/ end=/_\*/
syntax region DraftItalic start=/__/ end=/__/


syntax region DraftEditInsert start=/\[\[/ end=/\]\]/
syntax region DraftEditRemove start=/{{/ end=/}}/

syntax match DraftTodo /@@ .*/
syntax region DraftTodo  start=/@ / end=/ @/
]])
