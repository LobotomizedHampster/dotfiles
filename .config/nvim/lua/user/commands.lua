-- # COMMANDS # -- 

-- ## WRITING CMD ## --

local writing_enabled = false -- disable writing cmd by default 
vim.api.nvim_create_user_command("Wr", function()
    writing_enabled = not writing_enabled

    if writing_enabled then
        -- options
        vim.opt.linebreak = true
        vim.opt.breakindent = true
        vim.opt.spell = true
        vim.o.number = false -- disable line numbers
        vim.opt.colorcolumn = "" -- disable color column

        -- keymaps
        vim.keymap.set('n', 'j', 'gj')
        vim.keymap.set('n', 'k', 'gk')
        vim.keymap.set('n', '<Up>', 'gk')
        vim.keymap.set('n', '<Down>', 'gj')
        vim.keymap.set('n', '<ScrollWheelUp>', '3gk')
        vim.keymap.set('n', '<ScrollWheelDown>', '3gj')

        print("Writing ON")
    else
        -- reset options
        vim.opt.linebreak = not vim.opt.linebreak
        vim.opt.breakindent = not vim.opt.breakindent
        vim.opt.spell = not vim.opt.spell
        vim.o.number = not vim.o.number
        vim.opt.colorcolumn = default_colorcolumn

        -- delete keymaps
        vim.keymap.del('n', 'j')
        vim.keymap.del('n', 'k')
        vim.keymap.del('n', '<Up>')
        vim.keymap.del('n', '<Down>')
        vim.keymap.del('n', '<ScrollWheelUp>')
        vim.keymap.del('n', '<ScrollWheelDown>')

        print("Writing OFF")
    end
end, {})


-- ## EDITING CMD ## --

local editing_enabled = false
vim.api.nvim_create_user_command("Ed", function()
    editing_enabled = not editing_enabled

    vim.diagnostic.config({
        signs = editing_enabled,
        underline = editing_enabled,
    })

    if editing_enabled then
        -- options
        vim.opt.spell = true

        -- keymaps
        vim.keymap.set('n', 'z+', function()
            vim.diagnostic.open_float()
        end)

        print("Editing ON")
    else
        -- reset options
        vim.opt.spell = not vim.opt.spell
        vim.cmd("LspStop")

        -- delete keymaps
        vim.keymap.del('n', 'z+')

        print("Writing OFF")
    end
end, {})


-- ## SPELL CHECKING ##
-- gets spelling results from a word using telescope, then corrects the word
function check_spelling()
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
        text = i .. " " .. pair, -- put a number next to the string
        value = pair
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
          ordinal = entry.text
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


-- open nvim config files in a split window
vim.api.nvim_create_user_command("EditConfig", function()
    vim.cmd.split(vim.fn.stdpath("config"))
end, {})



-- # KEYBINDS # --

-- Check spelling or the word under the cursor
vim.keymap.set('n', '<Return>', check_spelling, { noremap = true, silent = true })

-- Set ctrl + c to copy text
vim.keymap.set("v", "<C-c>", "\"+y",  { noremap = true, silent = true })
-- Set ctrl + x to cut text
vim.keymap.set("v", "<C-x>", "d",  { noremap = true, silent = true })
