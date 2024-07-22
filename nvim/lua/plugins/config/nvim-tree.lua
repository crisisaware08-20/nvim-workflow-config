require('nvim-tree').setup {
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 55,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},

	update_focused_file = {
		enable = true,         -- Enables the feature to update the focused file
		update_cwd = true,     -- Changes the cwd of the tree to that of the file
	}
}
