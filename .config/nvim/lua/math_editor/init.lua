--[[ TODO

- look for the string "/"
- replace it with:
  num_before
  ---------- 
  num_after
- determine the amount of hypens to use (depends on max num of chars in either)
- center the text with less chars
- update the text when changing

--]]



local M = {}

function M.hello()
  local modifying = false
  vim.api.nvim_create_autocmd("TextChangedI", {
    callback = function()
      if modifying then return end
      modifying = true
  
      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

      local new_line = line:gsub("2x", "2x\n-")
      local lines = vim.split(new_line, "\n")
  
      vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })
  
      modifying = false
    end,
  })
end

return M
