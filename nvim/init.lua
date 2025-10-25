
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})
vim.pack.add({"https://github.com/NickvanDyke/opencode.nvim"})
vim.pack.add({"https://github.com/folke/snacks.nvim"})
vim.pack.add({"https://github.com/Saghen/blink.cmp"})
vim.pack.add({"https://github.com/m4xshen/autoclose.nvim"})
vim.pack.add({"https://github.com/nvim-telescope/telescope.nvim"})
vim.pack.add({"https://github.com/nvim-lua/plenary.nvim"})
vim.pack.add({"https://github.com/gbprod/yanky.nvim"})

require('config.options')
require('config.keymaps')
require('config.commands')
require('config.autocmds')
require('lsp')

require('plugins.nick_opencode')
require('plugins.blink')
require('plugins.autoclose')
require('plugins.telescope')
require('plugins.yanky')

-- Explore things
require('plugins.my_plugin')


