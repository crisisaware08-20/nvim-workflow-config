require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
			},
			n = {
				["<esc>"] = require("telescope.actions").close,
			}
		},
		layout_strategy = 'horizontal',
		layout_config = { height = 0.99, width = 0.99 },
		selection_strategy = "reset",
	},
	pickers = {
		-- find_files = {
		-- 	theme = "dropdown",
		-- }
		-- Default configuration for builtin pickers goes here:

		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
		lsp_document_symbols = {
			symbol_width = 80,
			theme = "dropdown",
			layout_config = {
				width = 0.8,
			},
		},
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure

		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		["ui-select"] = {
			require('telescope.themes').get_dropdown {
			}
		}
	}
}

require('telescope').load_extension('fzy_native')
require("telescope").load_extension("ui-select")
