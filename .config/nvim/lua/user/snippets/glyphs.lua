local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

local aliases = {
    { triggers = { "sqrt", "rt" }, output = "√" },
    { triggers = { "cbrt", "rt3" }, output = "∛" },
    { triggers = { "^2" }, output = "²" },
    { triggers = { "^3" }, output = "³" },
    { triggers = { "pi" }, output = "π" },
    { triggers = { "DELTA", "DT" }, output = "Δ" },
}

local snippets = {}

-- add snippets to luasnip
for _, item in ipairs(aliases) do
    for _, trigger in ipairs(item.triggers) do
        table.insert(snippets,
            s(trigger, {
                t(item.output)
            })
        )
    end
end

--[[
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").expand_or_jump()
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
      "i",
      true
    )
  end
end)
--]]


return snippets
