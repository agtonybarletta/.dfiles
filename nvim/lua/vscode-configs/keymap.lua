print('loading vscdode.keymap.lua')

local M = {}
local vscode = require('vscode')

M.commands = {
    ["n-<A-j>"] = function() vscode.action('workbench.action.navigateDown') end,
    ["n-<A-k>"] = function() vscode.action('workbench.action.navigateUp') end,
    ["n-<A-h>"] = function() vscode.action('workbench.action.navigateLeft') end,
    ["n-<A-l>"] = function() vscode.action('workbench.action.navigateRight') end,

    ["n-<A-t>t"] = function() vscode.action('workbench.action.terminal.focusNext' ) end,
    ["n-<A-t>n"] = function() vscode.action('workbench.action.terminal.new' ) end,
    -- bug on alt-n
    ["n-<A-n>s"] = function() vscode.action('explorer.newFile' ) end,

    ["n-<A-n>v"] = "", --"<cmd>vsp | :enew<cr>",
    ["n-<A-n>t"] = "", --"<cmd>tabe<cr>",
    
    
    ["n-<A-C>"] = function() vscode.action('workbench.action.closeActiveEditor') end,
    
    ["n-<A-z>"] = function() vscode.action('workbench.action.toggleZenMode') end,

    ["n-<leader>fg"] = function() vscode.action('workbench.action.quickOpen', { args = { '%' }}) end,
    ["n-<leader>ff"] = function() vscode.action('workbench.action.quickOpen' ) end,
    ["n-<leader>fs"] = function() vscode.action('workbench.action.quickOpen', { args = { '#' }}) end,
    
    ["n-<leader>c"] = function() vscode.action('workbench.action.quickOpen', { args = { '?' }}) end,
    ["n-<leader>Cn"] = function() vscode.action('workbench.action.chat.newChat') end,
    ["n-<leader>p"] = function() vscode.action('markdown.showPreview') end,

    ['n-<leader>K'] = function() vscode.action('editor.action.showHover') end,
    ['n-<leader>gd'] = function() vscode.action('editor.action.revealDefinition') end,
    ['n-<leader>gD'] = function() vscode.action('editor.action.revealDeclaration') end,
    ['n-<leader>gi'] = function() vscode.action('editor.action.goToImplementation') end,
    ['n-<leader>gr'] = function() vscode.action('editor.action.referenceSearch.trigger') end,
    ['n-<leader>ga'] = function() vscode.action('editor.action.quickFix') end,
    ['n-<leader>gf'] = function() vscode.action('editor.action.formatDocument') end,
    ['n-<leader>gR'] = function() vscode.action('editor.action.rename') end,

    ['n-<A-Up>']    = function() vscode.action('workbench.action.increaseViewHeight') end,
    ['n-<A-Down>']  = function() vscode.action('workbench.action.decreaseViewHeight') end,
    ['n-<A-Right>'] = function() vscode.action('workbench.action.increaseViewWidth') end,
    ['n-<A-Left>']  = function() vscode.action('workbench.action.decreaseViewWidth') end,
    ['v->'] = ">gv",
    ['v-<'] = "<gv",
    
    
    ['n-<A-e>1'] = function() vscode.action('workbench.view.explorer') end,
    ['n-<A-e>2'] = function() vscode.action('workbench.action.findInFiles') end,
    ['n-<A-e>3'] = function() vscode.action('workbench.view.scm') end,
    ['n-<A-e>4'] = function() vscode.action('workbench.view.debug') end,
    ['n-<A-e>5'] = function() vscode.action('workbench.panel.chat') end,
    ['n-<A-e>0'] = function() vscode.action('workbench.action.toggleSidebarVisibility') end,

    ['n-<A-t>1'] = function() vscode.action('workbench.actions.view.problems') end,
    ['n-<A-t>2'] = function() vscode.action('workbench.action.output.toggleOutput') end,
    ['n-<A-t>3'] = function() vscode.action('workbench.debug.action.toggleRepl') end,
    ['n-<A-t>4'] = function() vscode.action('workbench.action.terminal.toggleTerminal') end,
    ['n-<A-t>0'] = function() vscode.action('workbench.action.togglePanel') end,

  
}
return M