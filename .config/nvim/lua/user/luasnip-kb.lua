-- Set tab in insert mode to replace text (uses luasnip)
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").expand_or_jump()
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
      "n",
      true
    )
  end
end)

