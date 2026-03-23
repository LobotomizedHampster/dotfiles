-- # NVIM CONFIG # --

-- ## FILES ## --

require("user.commands")  -- custom commands and keybinds
require("user.packages")  -- package manager and packages
require("user.options")   -- default options
require("user.filetypes") -- Custom syntax highlighting for drafts (.dft)

vim.cmd.colorscheme("doodle") -- set color scheme


vim.g.mapleader = "\\"      -- sets leader to SPACE

--[[
function check_word ()
  local word = vim.fn.expand("<cword>")
  print(word)
  local word = vim.fn.expand("<cword>")
  local suggestions = vim.fn.spellsuggest(word)

  print(vim.inspect(suggestions))
  
  local formatted_suggestions = {}

  for i, pair in ipairs(suggestions) do
    table.insert(formatted_suggestions, {
        text = pair
    })
  end

  for i, f in ipairs(formatted_suggestions) do
      print(f.text)
  end

end
--]]
--[[
function my_picker()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  pickers.new({}, {
    prompt_title = "My Picker",
    finder = finders.new_table({
      results = {
        { text = "Config", path = "~/.config/nvim/init.lua" },
        { text = "Plugins", path = "~/.config/nvim/lua/plugins.lua" }
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.text,
          ordinal = entry.text
        }
      end
    }),
    sorter = conf.generic_sorter({})
  }):find()
end
--]]

--[[
function my_picker()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values



  local word = vim.fn.expand("<cword>")
  print(word)
  local word = vim.fn.expand("<cword>")
  local suggestions = vim.fn.spellsuggest(word)

  print(vim.inspect(suggestions))
  
  local formatted_suggestions = {}

  for i, pair in ipairs(suggestions) do
    table.insert(formatted_suggestions, {
        text = i .. ": " .. pair,
        value = pair
    })
  end

  pickers.new({}, {
    prompt_title = "Pick Spelling",
    finder = finders.new_table({
      results = formatted_suggestions,

      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.text,
          ordinal = entry.text
        }
      end
    }),
    sorter = conf.generic_sorter({}),

  attach_mappings = function(_, _)
    actions.select_default:replace(function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)

      vim.cmd("normal! ciw" .. selection.value)

      -- go back to normal mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    end)
    return true
  end
  }):find()
end
--]]

-- gets spelling results from a word using telescope, then corrects the word
function my_picker()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  local word = vim.fn.expand("<cword>") -- get word under the cursor

   -- get the spelling options for the word
  local suggestions = vim.fn.spellsuggest(word) 
  local formatted_suggestions = {}

  -- format the spelling results correctly
  for i, pair in ipairs(suggestions) do
    table.insert(formatted_suggestions, {
        text = i .. ": " .. pair, -- put a number next to the string
        value = pair,
        search = i .. " "
    })
  end
  
  -- create a custom picker with our formatted spelling table
  pickers.new({}, {
    prompt_title = "Pick Spelling", -- title of picker
    finder = finders.new_table({
      results = formatted_suggestions, -- the results shown

      entry_maker = function(entry)
        return {
          value = entry.value, -- what the selection does
          display = entry.text, -- what is displayed as the selection
          ordinal = entry.search -- what message is actully being searched 
        }
      end
    }),
    sorter = conf.generic_sorter({}), -- how the options are shown

  attach_mappings = function(_, _)
    actions.select_default:replace(function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)

      -- replaces the word with the selection
      vim.cmd("normal! ciw" .. selection.value)

      -- go back to normal mode
      vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes(
              "<Esc>", true, false, true), 
          "n", true)
    end)
    return true
  end
  }):find()
end

