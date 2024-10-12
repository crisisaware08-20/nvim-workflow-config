local P = {}

local telescope_builtin = require('telescope.builtin')
local wk = require("which-key")


function P.git_keys()
	wk.add({
		-- Telescope
		{
			mode = { "n", "v" },
			{ "<leader>gbc", telescope_builtin.git_bcommits, desc = "Git buffer commits" },
			{ "<leader>gc",  telescope_builtin.git_commits,  desc = "Git workspace commits" },
			{ "<leader>gb",  telescope_builtin.git_branches, desc = "List all branches" },
			{ "<leader>gs",  telescope_builtin.git_status,   desc = "Git status" },
		},
	}
	)
end

-- nvim-lspconfig
function P.lsp_keys()
	wk.add({

		-- Diagnostic
		{
			{ "[d",        vim.diagnostic.goto_prev,      desc = "Go to previous diagnostic" },
			{ "]d",        vim.diagnostic.goto_next,      desc = "Go to next diagnostic" },
			{ "<space>ql", vim.diagnostic.setloclist,     desc = "Set loclist" },
			{ "<space>e",  telescope_builtin.diagnostics, desc = "DiagnSet loclistose all" }

		},
		{
			-- Go to
			{ "gd", vim.lsp.buf.definition,      desc = "Go to definition" },
			{ "gD", vim.lsp.buf.declaration,     desc = "Go to declaration" },
			{ "gi", vim.lsp.buf.implementation,  desc = "Go to implementation" },
			{ "gt", vim.lsp.buf.type_definition, desc = "Jumps to the definition of the type of the symbol under the cursor" }
		},

		-- Search
		{
			{ "<leader>sr", telescope_builtin.lsp_references,     desc = "Show references of symbol under cursor" },
			{ "<leader>si", telescope_builtin.lsp_incoming_calls, desc = "Show incoming calls for the word under cursor" },
			{ "<leader>so", telescope_builtin.lsp_outgoing_calls, desc = "Show outgoing calls for the word under cursor" },
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
			mode = { "n", "v" },
			{ "<leader>gt", function() require("jdtls.tests").goto_subjects() end, desc = "Go to test" },
			{ "<leader>oi", function() jdtls.organize_imports() end,               desc = "Organize Imports" },
			-- { "<leader>ev", function() jdtls.extract_variable() end, desc = "Extract Variable" }, -- conflicts with init.lua
			{ "<leader>em", function() jdtls.extract_method() end,                 desc = "Extract Method" },
			{ "<leader>jc", function() jdtls.compile('incremental') end,           desc = "Compile Incremental" },
			{ "<leader>em", function() jdtls.extract_method(true) end,             desc = "Extract Method" },
			{ "<leader>ev", function() jdtls.extract_variable(true) end,           desc = "Extract Variable" },
			{ ",tm",        function() jdtls.test_nearest_method() end,            desc = "Test Nearest Method" },
			{ ",tc",        function() jdtls.test_class() end,                     desc = "Test Class" },
		},
	})
end

function P.search_keys()
	wk.add({
		-- Telescope
		{
			mode = { "n", "v" },
			{ "<leader>b",  telescope_builtin.buffers,  desc = "Search for buffers" },
			{ "<leader>of", telescope_builtin.oldfiles, desc = "Old files" },
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
			{ "<leader>fs", telescope_builtin.lsp_document_symbols, desc = "File symbols" },
			{ "<leader>sf", telescope_builtin.find_files,           desc = "Search for file" },
			{ "<leader>sh", telescope_builtin.help_tags,            desc = "Search help" },
			{ "<leader>ss", telescope_builtin.grep_string,          desc = "Search for selection in files" },
			{ "<leader>lg", telescope_builtin.live_grep,            desc = "Live grep" },
		},
	})
end

vim.keymap.set('n', "<leader>wd", "<CMD>NvimTreeFindFileToggle<cr>")

function P.copilot_chat_keys()
	wk.add({
		{
			mode = { "n", "v" },

			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat"
			},
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
		},
	})
end

function P.tab_buffers_keys()
	wk.add({
		{
			mode = { "n", "v" },
			{ "<leader><leader>b", "<CMD>BufferCloseAllButVisible<CR>", desc = "Close all buffer but visible" },
			{ "<leader>qb", "<CMD>BufferClose<CR>", desc = "Close tab buffer" },
			{ "<leader>jt", "<CMD>BufferPick<CR>", desc = "Pick tab" },
			{ "<leader>1", "<Cmd>BufferGoto 1<CR>", desc = "Go to tab"},
			{ "<leader>2", "<Cmd>BufferGoto 2<CR>", desc = "Go to tab"},
			{ "<leader>3", "<Cmd>BufferGoto 3<CR>", desc = "Go to tab"},
			{ "<leader>4", "<Cmd>BufferGoto 4<CR>", desc = "Go to tab"},
			{ "<leader>5", "<Cmd>BufferGoto 5<CR>", desc = "Go to tab"}
		},
	})
end

return P
