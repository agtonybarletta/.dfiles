print('loading nvim.init.lua')

M = require('nvim-configs.functions')

-- ~/.config/nvim/init.lua
require("float-buf").setup({
  width  = 0.7,
  height = 0.6,
  border = "double",
})
