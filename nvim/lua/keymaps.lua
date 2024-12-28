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
	return {
		-- Diagnostic
		{
			mode = { "n", "v" },
			{ "[d",        vim.diagnostic.goto_prev,                 desc = "Prev Diagnostic" },
			{ "]d",        vim.diagnostic.goto_next,                 desc = "Next Diagnostic" },
			{ "<space>ql", vim.diagnostic.setloclist,                desc = "Diagnostic to quicklist" },
			{ "<space>e",  require("telescope.builtin").diagnostics, desc = "Telescope diagnostics" },
		},
		-- Go to
		{
			mode = { "n", "v" },
			{ "gd", vim.lsp.buf.definition,      desc = "Go to def" },
			{ "gD", vim.lsp.buf.declaration,     desc = "Go to decl" },
			{ "gi", vim.lsp.buf.implementation,  desc = "Go to impl" },
			{ "gt", vim.lsp.buf.type_definition, desc = "Go to type def" },
		},
		-- Search
		{
			mode = { "n", "v" },
			{ "<leader>sr", require("telescope.builtin").lsp_references,     desc = "Telescope LSP references" },
			{ "<leader>si", require("telescope.builtin").lsp_incoming_calls, desc = "Show incoming calls for the word under cursor" },
			{ "<leader>so", require("telescope.builtin").lsp_outgoing_calls, desc = "Telescope outgoing calls" },
		},
		-- Refactor
		{
			mode = { "n", "v" },
			{ "<leader>re", vim.lsp.buf.rename, desc = "Rename symbol under cursor" },
			{ "<leader>cf", vim.lsp.buf.format, desc = "Format the current buffer" },
		},
		-- Workspace
		{
			mode = { "n", "v" },
			{ "<leader>wa", vim.lsp.buf.add_workspace_folder,                                        desc = "Add workspace folder" },
			{ "<leader>wr", vim.lsp.buf.remove_workspace_folder,                                     desc = "Remove workspace folder" },
			{ "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List workspace folders" },
		},
		-- Others
		{
			mode = { "n", "v" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
			{ "K",          vim.lsp.buf.hover,       desc = "Hover documentation" },
		},
	}
end

local jdtls = require('jdtls')

-- Avoiding copying each time attaching to buffer, probably there is a better way
local lsp_common_keys = vim.deepcopy(P.lsp_keys() or {})
function P.jdtls_keys()
	local jdtl_keys =
	{
		{
			mode = { "n", "v" },
			{ "<leader>gt", function() require("jdtls.tests").goto_subjects() end, desc = "Go to test" },
			{ "<leader>oi", function() jdtls.organize_imports() end,               desc = "Organize Imports" },
			{ "<leader>jc", function() jdtls.compile('incremental') end,           desc = "Compile Incremental" },
			-- { "<leader>em", function() jdtls.extract_method(true) end,             desc = "Extract Method" },
			-- { "<leader>ec", function() jdtls.extract_constant(true) end,           desc = "Extract Constant" },
			-- { "<leader>ev", function() jdtls.extract_variable(true) end,           desc = "Extract Variable" },
			-- { ",tm",        function() jdtls.test_nearest_method() end,            desc = "Test Nearest Method" },
			-- { ",tc",        function() jdtls.test_class() end,                     desc = "Test Class" },
			{ ",tt",        function() require('jdtls.dap').pick_test() end,       desc = "Prompt for a test method" },
		}
	}
	return vim.list_extend(lsp_common_keys, jdtl_keys)
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
			{ "<leader>ff", telescope_builtin.find_files,           desc = "Search for file" },
			{ "<leader>ht", telescope_builtin.help_tags,            desc = "Search help" },
			{ "<leader>gs", telescope_builtin.grep_string,          desc = "Search for selection in files" },
			{ "<leader>lg", telescope_builtin.live_grep,            desc = "Live grep" },
			{
				"<leader>fc",
				function()
					telescope_builtin.find_files({
						prompt_title = "Neovim Runtime Files",
						cwd = os.getenv('HOME') .. '/nvim-workflow-config/nvim/',
						hidden = true,
						no_ignore = true,
					})
				end,
				desc = "Search Neovim configuration files"
			},
			{ "<leader>ch", telescope_builtin.command_history, desc = "Command history" },
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

return P
