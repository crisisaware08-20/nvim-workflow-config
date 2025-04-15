local M = {}

-- AI assistance
-- require('plugins/config/copilot-chat')
require("plugins/config/copilot")

-- Basics
require("plugins/config/gitsigns")
require("plugins/config/nvim-tree")
require("plugins/config/telescope")
require("plugins/config/blink")

-- Folding, zR, zM
require("plugins/config/ufo")

-- Treesitter and custom modules
require("plugins/config/treesitter")
require("plugins/treesiter/ts_modules")

-- LSPs
require("plugins/config/lsp-config")

-- Formatter
require("plugins/config/conform")

-- Keys
local keys = require("keymaps").git_keys()
require("util-module").set_global_keymaps(require("keymaps").git_keys())
require("keymaps").search_keys()
require("keymaps").other_keys()

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").config.set_config({ debug = true })

return M
