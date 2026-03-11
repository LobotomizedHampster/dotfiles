local checked_character = "/"

local checked_checkbox = "%[" .. checked_character .. "%]"
local unchecked_checkbox = "%[ %]"

local line_contains_unchecked = function(line)
	return line:find(unchecked_checkbox)
end

local line_contains_checked = function(line)
	return line:find(checked_checkbox)
end

local line_with_checkbox = function(line)
	-- return not line_contains_a_checked_checkbox(line) and not line_contains_an_unchecked_checkbox(line)
	return line:find(checked_checkbox)
		or line:find(unchecked_checkbox)
		or line:find(checked_checkbox)
		or line:find(unchecked_checkbox)
end

local checkbox = {
	check = function(line)
		return line:gsub(unchecked_checkbox, checked_checkbox, 1)
	end,

	uncheck = function(line)
		return line:gsub(checked_checkbox, unchecked_checkbox, 1)
	end,

}

local M = {}

M.toggle = function()
	local bufnr = vim.api.nvim_buf_get_number(0)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local start_line = cursor[1] - 1
	local current_line = vim.api.nvim_buf_get_lines(bufnr, start_line, start_line + 1, false)[1] or ""

	-- If the line contains a checked checkbox then uncheck it.
	-- Otherwise, if it contains an unchecked checkbox, check it.
	local new_line = ""

	if not line_with_checkbox(current_line) then
		new_line = current_line
	elseif line_contains_unchecked(current_line) then
		new_line = checkbox.check(current_line)
	elseif line_contains_checked(current_line) then
		new_line = checkbox.uncheck(current_line)
	end

	vim.api.nvim_buf_set_lines(bufnr, start_line, start_line + 1, false, { new_line })
	vim.api.nvim_win_set_cursor(0, cursor)
end

vim.api.nvim_create_user_command("ToggleCheckbox", M.toggle, {})

return M

