require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist, -- For normal mode
				["<C-u>"] = false,
			},
			n = {
				["<esc>"] = require("telescope.actions").close,
				["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist, -- For normal mode
			}
		},
		layout_strategy = 'vertical',
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
				layout_config = {
					preview_cutoff = 1, -- Preview should always show (unless previewer = false)
					width = function(_, max_columns, _)
						return math.min(max_columns, 150)
					end
				},

				winblend = 20, -- Optional: Adjust transparency
			}
		}
	}
}

require('telescope').load_extension('fzy_native')
require("telescope").load_extension("ui-select")
