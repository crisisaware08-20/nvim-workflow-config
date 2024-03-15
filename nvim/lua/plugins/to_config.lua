local M = {}

vim.opt.termguicolors=true

require('plugins/config/bamboo')
require('plugins/config/cmp')
require('plugins/config/gitsigns')
require('plugins/config/noice')
require('plugins/config/nvim-tree')
require('plugins/config/telescope')
require('plugins/config/which-key')

-- LSPs
require('mason').setup()
require('mason-lspconfig').setup()
require('plugins/config/lsps/bash_ls')
require('plugins/config/lsps/lua_ls')

require("nvim-surround").setup()
require('keymaps').lsp_keys()
require('keymaps').hop()
require('keymaps').telescope()
require('feline').setup()
require('nvim_comment').setup()

return M
