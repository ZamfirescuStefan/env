require('config.options')
require('config.remaps')
require('config.autocmds')
require('config.lazy')
require('config.commands')

-- Source local machine config if it exists
local local_config = vim.fn.expand("~/.nvim.local")
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end
