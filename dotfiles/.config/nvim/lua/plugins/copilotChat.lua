return
{
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    config = function()
        -- to specify a file in CopilitChat use #file:path/to/file
        require("CopilotChat").setup({
          -- model = 'gpt-5',
          temperature = 0.3,
          window = {
            layout = 'vertical',
            width = 0.5,
          },
          auto_insert_mode = true,
        })

        vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle CopilotChat panel" })
        vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>", { desc = "Ask CopilotChat about selection" })

        -- Remove <C-l> mapping in CopilotChat buffers for both normal and insert mode
        vim.api.nvim_create_autocmd("BufEnter", {
          callback = function()
            local bufname = vim.api.nvim_buf_get_name(0)
            if bufname:match("CopilotChat") or vim.bo.filetype == "copilot-chat" then
              pcall(vim.keymap.del, "i", "<C-l>", { buffer = true })
              pcall(vim.keymap.del, "n", "<C-l>", { buffer = true })
            end
          end,
        })
    end,
}
