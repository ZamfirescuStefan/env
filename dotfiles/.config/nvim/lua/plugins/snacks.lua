return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            ui_select = true,
            layout = { preset = 'default' },
            win = {
                input = {
                    keys = {
                        ['<C-d>'] = { 'list_down', mode = { 'i', 'n' } },
                        ['<C-u>'] = { 'list_up', mode = { 'i', 'n' } },
                    },
                },
            },
        },
    },
    keys = {
        { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find files' },
        { '<leader>fa', function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = 'Find all files' },
        { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
        { '<leader>fo', function() Snacks.picker.recent() end, desc = 'Old files' },
        { '<leader>fw', function() Snacks.picker.grep_word() end, desc = 'Grep word under cursor', mode = { 'n', 'x' } },
        { '<leader>fv', function() Snacks.picker.grep_word() end, desc = 'Grep visual selection', mode = 'x' },
        { '<leader>fl', function() Snacks.picker.grep() end, desc = 'Live grep' },
        { '<leader>fp', function() Snacks.explorer({ cwd = vim.fn.expand('%:p:h') }) end, desc = 'File browser' },
        { '<leader>fr', function() Snacks.picker.resume() end, desc = 'Resume picker' },
        { '<leader>ml', function() Snacks.picker.marks() end, desc = 'Search project marks' },
        { "<leader>u", function() Snacks.picker.undo() end, desc = "Undo history" },

        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff Hunks" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    },
}

