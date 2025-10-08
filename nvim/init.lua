
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})
vim.pack.add({"https://github.com/NickvanDyke/opencode.nvim"})
vim.pack.add({"https://github.com/folke/snacks.nvim"})
-- vim.pack.add({""})

require('config.options')
require('config.keymaps')
require('config.commands')
require('lsp')

require('plugins.nick_opencode')
require('snacks').setup()
