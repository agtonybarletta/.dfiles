local keybindings = {}

keybindings.setup = function ()

    -- TODO change it for native neovim
    
    -- quick code
    -- vim.keymap.set('n', '<leader>c', function() vscode.action('workbench.action.quickOpen', { args = { '?' }}) end)
    -- vim.keymap.set('n', '<leader>fg', function() vscode.action('workbench.action.quickOpen', { args = { '%' }}) end)
    -- vim.keymap.set('n', '<leader>ff', function() vscode.action('workbench.action.quickOpen' ) end)
    
    -- terminal
    -- vim.keymap.set('n', '<leader>tt', function() vscode.action('workbench.action.terminal.focusNext' ) end)
    -- vim.keymap.set('n', '<leader>tn', function() vscode.action('workbench.action.terminal.new' ) end)

    -- windows movements
    -- vim.keymap.set('n', '<A-j>', function() vscode.action('workbench.action.navigateDown') end)
    -- vim.keymap.set('n', '<A-k>', function() vscode.action('workbench.action.navigateUp') end)
    -- vim.keymap.set('n', '<A-h>', function() vscode.action('workbench.action.navigateLeft') end)
    --vim.keymap.set('n', '<A-l>', function() vscode.action('workbench.action.navigateRight') end)

    -- lsp related keybindings
    -- vim.keymap.set('n', '<leader>K', function() vscode.action('editor.action.showHover') end)
    -- vim.keymap.set('n', '<leader>gD', function() vscode.action('editor.action.revealDefinition') end)
    -- vim.keymap.set('n', '<leader>gd', function() vscode.action('editor.action.revealDeclaration') end)
    -- vim.keymap.set('n', '<leader>gi', function() vscode.action('editor.action.goToImplementation') end)
    -- vim.keymap.set('n', '<leader>gr', function() vscode.action('editor.action.referenceSearch.trigger') end)
    -- vim.keymap.set('n', '<leader>ga', function() vscode.action('editor.action.quickFix') end)

    -- others
    -- vim.keymap.set('n', '<leader>gm', function() vscode.action('markdown.showPreview') end)
    -- vim.keymap.set('n', '<leader>z', function() vscode.action('workbench.action.toggleZenMode' ) end)
    

end

return keybindings