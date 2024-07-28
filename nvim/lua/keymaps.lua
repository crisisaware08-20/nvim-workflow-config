local P = {}

local telescope_builtin = require('telescope.builtin')
local jdtls = require('jdtls')
local wk = require("which-key")


local key_map = function(mode, key, result, desc)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true, desc = desc })
end

function P.common_keys()
	wk.add({
		-- Diagnostic
		{
			{ "[d",        vim.diagnostic.goto_prev,      desc = "Go to previous diagnostic" },
			{ "]d",        vim.diagnostic.goto_next,      desc = "Go to next diagnostic" },
			{ "<space>ql", vim.diagnostic.setloclist,     desc = "Set loclist" },
			{ "<space>e",  telescope_builtin.diagnostics, desc = "DiagnSet loclistose all" }
		},
	})
end

-- nvim-lspconfig
function P.lsp_keys()
	wk.add({
		{
			-- Go to
			{ "gd", vim.lsp.buf.definition,      desc = "Go to definition" },
			{ "gD", vim.lsp.buf.declaration,     desc = "Go to declaration" },
			{ "gi", vim.lsp.buf.implementation,  desc = "Go to implementation" },
			{ "gt", vim.lsp.buf.type_definition, desc = "Jumps to the definition of the type of the symbol under the cursor" }
		},

		-- Search
		{
			{ "<leader>sr", telescope_builtin.lsp_references, desc = "Show references of symbol under cursor" }
			-- { "<leader>ws", vim.lsp.buf.workspace_symbol, desc = "Search for a symbol in the workspace" }
		},

		-- Refactor
		{
			{ "<leader>re", vim.lsp.buf.rename, desc = "Rename symbol under cursor" },
			{ "<leader>cf", vim.lsp.buf.format, desc = "Format the current buffer" }
		},

		-- Workspace
		{
			{ "<leader>wa", vim.lsp.buf.add_workspace_folder,                                        desc = "Add workspace folder" },
			{ "<leader>wr", vim.lsp.buf.remove_workspace_folder,                                     desc = "Remove workspace folder" },
			{ "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List workspace folders" },
		},


		-- Others
		{
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Show code actions" },
			{ "K",          vim.lsp.buf.hover,       desc = "Show hover information" },
		},
	})
end

local jdtls = require('jdtls')

function P.jdtls_keys(bufnr)
	P.lsp_keys()
	wk.add({
		-- jdtls
		{
			{ "<leader>oi", function() jdtls.organize_imports() end,     desc = "Organize Imports" },
			-- { "<leader>ev", function() jdtls.extract_variable() end, desc = "Extract Variable" }, -- conflicts with init.lua
			{ "<leader>em", function() jdtls.extract_method() end,       desc = "Extract Method" },
			{ "<leader>jc", function() jdtls.compile('incremental') end, desc = "Compile Incremental" },
			{ "<leader>em", function() jdtls.extract_method(true) end,   desc = "Extract Method" },
			{ "<leader>ev", function() jdtls.extract_variable(true) end, desc = "Extract Variable" },
			{ ",tm",        function() jdtls.test_nearest_method() end,  desc = "Test Nearest Method" },
			{ ",tc",        function() jdtls.test_class() end,           desc = "Test Class" },
		},
	})
end

function P.telescope_keys()
	wk.add({
		-- Telescope
		{
			{ "<leader>b",  telescope_builtin.buffers,  desc = "[B]uffers" },
			{ "<leader>of", telescope_builtin.oldfiles, desc = "[O]ld [F]iles" },
			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
						winblend = 10,
						previewer = false,
					})
				end,
				desc = "Fuzzy find in current buffer"
			},
			{ "<leader>fs", telescope_builtin.lsp_document_symbols, desc = "[F]File structure" },
			{ "<leader>ff", telescope_builtin.find_files,           desc = "[F]ind [F]iles" },
			{ "<leader>ht", telescope_builtin.help_tags,            desc = "[H]elp [T]ags" },
			{ "<leader>gs", telescope_builtin.grep_string,          desc = "[G]rep [S]tring" },
			{ "<leader>lg", telescope_builtin.live_grep,            desc = "[L]ive [G]rep" },
		},
	})
end

vim.keymap.set('n', "<leader>wd", "<CMD>NvimTreeFindFileToggle<cr>")

return P
