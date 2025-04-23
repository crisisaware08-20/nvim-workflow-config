require("nvim-treesitter.configs").setup({
	-- A directory to install the parsers into.
	-- If this is excluded or nil parsers are installed
	-- to either the package dir, or the "site" dir.
	-- If a custom path is used (not nil) it must be added to the runtimepath.
	-- parser_install_dir = "/some/path/to/store/parsers",

	-- A list of parser names, or "all"
	ensure_installed = { "c", "lua", "rust", "typescript", "java", "go" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	-- ignore_install = { "javascript" },

	node_movement = {
		enable = true,
		keymaps = {
			move_up = "<a-k>",
			move_down = "<a-j>",
			move_left = "<a-h>",
			move_right = "<a-l>",
			swap_left = "<s-a-h>", -- will only swap when one of "swappable_textobjects" is selected
			swap_right = "<s-a-l>",
			select_current_node = "<leader><Cr>",
		},
		swappable_textobjects = { "@function.outer", "@parameter.inner", "@statement.outer" },
		allow_switch_parents = true, -- more craziness by switching parents while staying on the same level, false prevents you from accidentally jumping out of a function
		allow_next_parent = true, -- more craziness by going up one level if next node does not have children
	},

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		-- disable = { "c", "rust" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = ">",
			scope_incremental = "grc",
			node_decremental = "<",
		},
	},
})

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
