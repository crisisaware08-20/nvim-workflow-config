local M = {}

M.setup = function()
	local util = require("util-module")

	-- AI assistance
	require("plugins/config/copilot-chat")
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
	require("keymaps").common_keys()
	util.set_global_keymaps(require("keymaps").git_keys())
	util.set_global_keymaps(require("keymaps").search_keys())
	util.set_global_keymaps(require("keymaps").other_keys())

	-- Snippets
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip").config.set_config({ debug = true })
end

return M
