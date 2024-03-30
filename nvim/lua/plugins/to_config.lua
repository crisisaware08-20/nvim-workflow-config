local M = {}

vim.opt.termguicolors=true

require('plugins/config/bamboo')
require('plugins/config/cmp')
require('plugins/config/gitsigns')
-- require('plugins/config/noice')
require('plugins/config/nvim-tree')
require('plugins/config/telescope')
require('plugins/config/which-key')
require('plugins/config/treesitter')

-- LSPs

require('plugins/config/lsp-config')

require('keymaps').lsp_keys()
require('keymaps').hop()
require('keymaps').telescope()
require('feline').setup()
require('nvim_comment').setup()

return M
