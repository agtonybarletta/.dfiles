print('loading keymap.lua')
local M = {}

function M.init(commands)
  -- Commands

  -- Finds
  vim.keymap.set('n', '<leader>fg', commands["n-<leader>fg"])
  vim.keymap.set('n', '<leader>ff', commands["n-<leader>ff"])
  vim.keymap.set('n', '<leader>fs', commands["n-<leader>fs"])
  -- 
  -- Movements
  vim.keymap.set('n', '<A-j>', commands["n-<A-j>"])
  vim.keymap.set('n', '<A-k>', commands["n-<A-k>"])
  vim.keymap.set('n', '<A-h>', commands["n-<A-h>"])
  vim.keymap.set('n', '<A-l>', commands["n-<A-l>"])
  
  
  vim.keymap.set('n', '<A-t>n', commands["n-<A-t>n"])
  vim.keymap.set('n', '<A-t>t', commands["n-<A-t>t"])

  vim.keymap.set('n', '<A-n>s', commands["n-<A-n>s"])
  vim.keymap.set('n', '<A-n>v', commands["n-<A-n>v"])
  vim.keymap.set('n', '<A-n>t', commands["n-<A-n>t"])
  vim.keymap.set('n', '<A-C>', commands["n-<A-C>"])
  vim.keymap.set('n', '<A-z>', commands["n-<A-z>"])
  vim.keymap.set('n', '<leader>c', commands["n-<leader>c"])
  vim.keymap.set('n', '<leader>Cn', commands["n-<leader>Cn"])
  vim.keymap.set('n', '<leader>p', commands["n-<leader>p"])
  vim.keymap.set('n', '<leader>K', commands['n-<leader>K'])
  vim.keymap.set('n', '<leader>gd', commands['n-<leader>gd'])
  vim.keymap.set('v', '<leader>gd', commands['v-<leader>gd'])
  vim.keymap.set('n', '<leader>gD', commands['n-<leader>gD'])
  vim.keymap.set('n', '<leader>gi', commands['n-<leader>gi'])
  vim.keymap.set('n', '<leader>gr', commands['n-<leader>gr'])
  vim.keymap.set('v', '<leader>gr', commands['v-<leader>gr'])
  vim.keymap.set('n', '<leader>ga', commands['n-<leader>ga'])
  vim.keymap.set('n', '<leader>gf', commands['n-<leader>gf'])
  vim.keymap.set('n', '<leader>gR', commands['n-<leader>gR'])

  vim.keymap.set('n', '<A-Up>', commands['n-<A-Up>'])
  vim.keymap.set('n', '<A-Down>', commands['n-<A-Down>'])
  vim.keymap.set('n', '<A-Left>', commands['n-<A-Left>'])
  vim.keymap.set('n', '<A-Right>', commands['n-<A-Right>'])
  vim.keymap.set('v', '>', commands['v->'])
  vim.keymap.set('v', '<', commands['v-<'])
  vim.keymap.set('n', '<A-e>1', commands['n-<A-e>1'])
  vim.keymap.set('n', '<A-e>2', commands['n-<A-e>2'])
  vim.keymap.set('n', '<A-e>3', commands['n-<A-e>3'])
  vim.keymap.set('n', '<A-e>4', commands['n-<A-e>4'])
  vim.keymap.set('n', '<A-e>5', commands['n-<A-e>5'])
  vim.keymap.set('n', '<A-e>0', commands['n-<A-e>0'])
  
  vim.keymap.set('n', '<A-t>1', commands['n-<A-t>1'])
  vim.keymap.set('n', '<A-t>2', commands['n-<A-t>2'])
  vim.keymap.set('n', '<A-t>3', commands['n-<A-t>3'])
  vim.keymap.set('n', '<A-t>4', commands['n-<A-t>4'])
  vim.keymap.set('n', '<A-t>0', commands['n-<A-t>0'])

  -- 
  -- others

end
return M
