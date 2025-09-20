return {
    'github/copilot.vim',

    config = function()
        vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
        vim.keymap.set('i', '<C-H>', 'copilot#Dismiss()', { expr = true, silent = true, desc = "Copilot Dismiss suggestion" })
        vim.keymap.set('i', '<C-J>', 'copilot#Next()', { expr = true, silent = true, desc = "Copilot Next suggestion" })
        vim.keymap.set('i', '<C-K>', 'copilot#Previous()', { expr = true, silent = true, desc = "Copilot Previous suggestion" })
    end
}
