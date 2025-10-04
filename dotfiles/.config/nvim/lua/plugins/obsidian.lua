return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/MyVault",
            }
        },
        legacy_commands = false,
        conceallevel = 2,
        disable_frontmatter = true,
        notes_subdir = "Notes",
        new_notes_location = "notes_subdir",
        templates = {
            folder = "Templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
    },
    config = function(_, opts)
        local obsidian = require("obsidian")
        obsidian.setup(opts)

        vim.keymap.set("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Obsidian quick switch" })
        vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Obsidian search notes" })
        vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian new_from_template<CR>", { desc = "Obsidian new from template" })
        vim.keymap.set("n", "<leader>ogd", "<cmd>Obsidian follow_link<CR>", { desc = "Obsidian follow link" })
        vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian back_links<CR>", { desc = "Obsidian back links" })

        vim.keymap.set("n", "<leader>of", function()
            vim.cmd.Ex("~/MyVault") end, { desc = "Open folder in netrw" })
        end,
}
