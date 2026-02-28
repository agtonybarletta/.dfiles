print('loading init.lua')

vim.g.mapleader = " "

-- line numbers relative
vim.opt.nu = true
vim.opt.relativenumber = true

-- tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- enable/disable seaching all occurrency while typing
vim.opt.hlsearch = false
-- enable/disable searching higlight on one occurency while typing
vim.opt.incsearch = true

-- keep at least x number of line above and below when scrolling
vim.opt.scrolloff = 4

-- time nvim waits (in ms) before triggering plugins etc
vim.opt.updatetime = 200

vim.opt.wrap = false

-- set splitright splitbelow
vim.o.splitright = true
vim.o.splitbelow = true

vim.g.markdown_folding = 1

vim.g.markdown_enable_folding = 1


local module = {}
local commands = {}
if vim.g.vscode then
  module = require("vscode-configs")
  commands = require("vscode-configs.keymap").commands
else
  module = require("nvim-configs")
  commands = require("nvim-configs.keymap").commands
end

local keymap = require('keymap')
keymap.init(commands)