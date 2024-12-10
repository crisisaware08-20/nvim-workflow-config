local M = {}

-- vim.opt.termguicolors=true

require('plugins/config/bamboo')
require('plugins/config/cmp')
require('plugins/config/copilot-chat')
require('plugins/config/gitsigns')
require('plugins/config/nvim-tree')
require('plugins/config/telescope')
require('plugins/config/treesitter')
require('plugins/config/ufo')
-- require('plugins/config/copilot')

-- LSPs

require('plugins/config/lsp-config')

require('keymaps').lsp_keys()
require('keymaps').git_keys()
require('keymaps').search_keys()
require('keymaps').copilot_chat_keys()
require('feline').setup()
require('nvim_comment').setup()

return M
