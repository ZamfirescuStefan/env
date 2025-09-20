return
{
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    config = function()
        -- local copilot_chat = require("CopilotChat").setup()
        require("CopilotChat").setup({
          model = 'gpt-5',
          temperature = 0.3,
          window = {
            layout = 'vertical',
            width = 0.5,
          },
          auto_insert_mode = true,
        })
        vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle CopilotChat panel" })
        vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>", { desc = "Ask CopilotChat about selection" })
    end,
}
