local M = {}

-- AI assistance
-- require('plugins/config/copilot-chat')
require('plugins/config/copilot')

-- Basics
require('plugins/config/gitsigns')
require('plugins/config/nvim-tree')
require('plugins/config/telescope')
require('plugins/config/blink')

-- Folding, zR, zM
require('plugins/config/ufo')

-- Treesitter and custom modules
require('plugins/config/treesitter')
require('plugins/treesiter/ts_modules')

-- LSPs
require('plugins/config/lsp-config')

-- Keys
require('keymaps').git_keys()
require('keymaps').search_keys()
require('keymaps').other_keys()

-- ~/.local/share/nvim/lazy/friendly-snippets/
-- local path = vim.fn.stdpath("data") .. "/lazy/friendly-snippets/java"
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { path } })

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").config.set_config({ debug = true })
return M
