require('telescope').setup {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key"
			}
		},
		layout_strategy = 'vertical',
		layout_config = { height = 0.99 },
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
			display_items = {
				{ width = 20 },      -- This sets the width of the symbol column
				{ remaining = true } -- This makes the other column take up the remaining space
			},
			layout_config = {
				width = 0.9,
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
