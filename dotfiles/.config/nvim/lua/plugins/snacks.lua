return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            },
        },
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
        { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
        { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },

        -- find
        { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
        { '<leader>fa', function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = 'Find All Files' },
        { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
        { '<leader>fr', function() Snacks.picker.resume() end, desc = 'Resume' },
        { '<leader>fw', function() Snacks.picker.grep_word({ args = { "--hidden", "--no-ignore" } }) end, desc = 'Grep Word (All Files & Ignored)', mode = { 'n', 'x' } },
        { '<leader>fR', function() Snacks.picker.recent() end, desc = 'Recent' },

        -- grep
        { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
        { '<leader>sl', function() Snacks.picker.grep({ hidden = true, ignored = true }) end, desc = 'Grep All Files' },
        { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
        { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },

        -- search
        { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
        { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
        { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
        { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
        { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
        { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
        { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
        { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
        { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
        { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
        { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
        { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
        { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },

        -- git
        { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
        { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
        { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
        { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
        { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
        { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },

        { "<leader>kw", function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end, desc = "Toggle Wrap" },
        { "<leader>kc", function() Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):toggle() end, desc = "Toggle Conceal Level" },
    },
}

