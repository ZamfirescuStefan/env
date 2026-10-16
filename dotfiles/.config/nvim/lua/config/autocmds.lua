-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.filetype.add({ extension = { Jenkinsfile = 'groovy', jenkinsfile = 'groovy'} })

vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = function()
            return { vim.fn.split(vim.fn.getreg("+"), "\n") }
        end,
        ["*"] = function()
            return { vim.fn.split(vim.fn.getreg("*"), "\n") }

        end,
    },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.wo.number = true
        vim.wo.relativenumber = true
    end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  command = "setlocal conceallevel=0",
})
