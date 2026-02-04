
vim.g.mapleader = " "

function change_and_paste(...)
  -- change the selected test with the value of the current pasted text
  
  -- is this useful ? maybe not
  local reg_save = vim.fn.getreg('@@')

  -- delete everything addressed by the operator-map but do not storing in the paste reg,
  -- then paste
  local cmd = '`["_d`]"_dlP'
  vim.cmd.normal(cmd)
  
  -- backup reg, is this useful? 
  vim.fn.setreg('@@', reg_save)
end


if vim.g.vscode then

  local keybindings = require('vscodekeybindings')
  keybindings.setup()

    
else
  local keybindings = require('neovimkeybindings')
  keybindings.setup()
end


-- moving code

-- add/remove indentation
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- smart paste
-- mapping operator, for more info look :h map-operator
vim.api.nvim_set_keymap('n', 'C', ':set opfunc=v:lua.change_and_paste<CR>g@', { noremap = true, silent = true })