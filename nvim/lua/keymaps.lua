local P = {}

local telescope_builtin = require("telescope.builtin")
local wk = require("which-key")
local jdtls = require("jdtls")

function P.common_keys()
	-- Terminal window navigation
	vim.keymap.set("n", "<leader>te", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
	vim.keymap.set("t", "<c-k>", [[<C-\><C-N><C-w>k]])
	vim.keymap.set("i", "<c-k>", [[<C-\><C-N><C-w>k]])
	vim.keymap.set("t", "<c-h>", [[<C-\><C-N><C-w>h]])
	vim.keymap.set("i", "<c-h>", [[<C-\><C-N><C-w>h]])
	vim.keymap.set("t", "<c-l>", [[<C-\><C-N><C-w>l]])
	vim.keymap.set("i", "<c-l>", [[<C-\><C-N><C-w>l]])
	vim.keymap.set("t", "<c-j>", [[<C-\><C-N><C-w>j]])
	vim.keymap.set("i", "<c-j>", [[<C-\><C-N><C-w>j]])

	-- CopilotChat mappings
	vim.keymap.set("n", "<Space>o", "<cmd>CopilotChatOpen<cr>")
	vim.keymap.set("n", "<Space>t", "<cmd>CopilotChatToggle<cr>")
	vim.keymap.set("n", "<Space><CR>", "<cmd>CopilotChatExecute<cr>")

	-- Quick access to configuration files, so far .zshrc and init.lua
	vim.keymap.set("n", "<leader>ev", "<cmd>hide e ~/.config/nvim/init.lua<CR>", { desc = "[E]dit init.lua" })
	vim.keymap.set("n", "<leader>ez", "<cmd>hide e ~/.zshrc<CR>")
	-- Window navigation
	vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap = true, silent = false })
	vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true, silent = false })
	vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true, silent = false })
	vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap = true, silent = false })
	-- Window management
	vim.keymap.set("n", "<Tab>l", "<c-w><S-l>", { noremap = true, silent = false })
	vim.keymap.set("n", "<Tab>h", "<c-w><S-h>", { noremap = true, silent = false })
	vim.keymap.set("n", "<Tab>k", "<c-w><S-k>", { noremap = true, silent = false })
	vim.keymap.set("n", "<Tab>j", "<c-w><S-j>", { noremap = true, silent = false })
	vim.keymap.set("n", "qw", "<c-w>c", { noremap = true, silent = false })
	vim.keymap.set("n", "<leader>q", ":cclose<CR>", { noremap = true, silent = true, desc = "Close quick list" })
	vim.keymap.set("n", "<S-l>", "<c-w>>", { noremap = true, silent = false })
	vim.keymap.set("n", "<S-h>", "<c-w><", { noremap = true, silent = false })
	vim.keymap.set("n", "<S-e>", "<c-w>+", { noremap = true, silent = false })
	vim.keymap.set("n", "<S-y>", "<c-w>-", { noremap = true, silent = false })
	vim.keymap.set("n", "tl", "", {
		noremap = true,
		silent = true,
		callback = function()
			vim.cmd("set number!")
			vim.cmd("set relativenumber!")
		end,
	})
	vim.keymap.set("n", "<leader>cd", function()
		require("util-module").change_nvim_directory_to(vim.fn.expand("%:p:h"))
		require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
	end, { noremap = true, silent = true, desc = "Change working directory" })
end

function P.git_keys()
	return {
		{
			mode = { "n", "v" },
			{
				"<leader>gbc",
				function()
					require("telescope.builtin").git_bcommits()
				end,
				desc = "Git buffer commits",
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits()
				end,
				desc = "Git workspace commits",
			},
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "List all branches",
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status()
				end,
				desc = "Git status",
			},
		},
	}
end

function P.lsp_keys()
	return {
		-- Diagnostic
		{
			mode = { "n", "v" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
			{ "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
			{ "<space>ql", vim.diagnostic.setloclist, desc = "Diagnostic to quicklist" },
			{ "<space>e", require("telescope.builtin").diagnostics, desc = "Telescope diagnostics" },
		},
		-- Go to
		{
			mode = { "n", "v" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to def" },
			{
				"gD",
				function()
					vim.cmd("vsplit")
					vim.lsp.buf.definition()
				end,
				desc = "Go to def",
			},
			{ "gi", vim.lsp.buf.implementation, desc = "Go to impl" },
			{ "gt", vim.lsp.buf.type_definition, desc = "Go to type def" },
		},
		-- Search
		{
			mode = { "n", "v" },
			{
				"<leader>sr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "Telescope LSP references",
			},
			{
				"<leader>si",
				function()
					require("telescope.builtin").lsp_incoming_calls()
				end,
				desc = "Show incoming calls for the word under cursor",
			},
			{
				"<leader>so",
				function()
					require("telescope.builtin").lsp_outgoing_calls()
				end,
				desc = "Telescope outgoing calls",
			},
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
			{
				"<leader>wa",
				vim.lsp.buf.add_workspace_folder,
				desc = "Add workspace folder",
			},
			{
				"<leader>wr",
				vim.lsp.buf.remove_workspace_folder,
				desc = "Remove workspace folder",
			},
			{
				"<leader>wl",
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				desc = "List workspace folders",
			},
		},
		-- Others
		{
			mode = { "n", "v" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
			{ "K", vim.lsp.buf.hover, desc = "Hover documentation" },
		},
	}
end

-- Avoiding copying each time attaching to buffer, probably there is a better way
local lsp_common_keys = vim.deepcopy(P.lsp_keys() or {})

function P.jdtls_keys()
	local dap_widget = require("dap.ui.widgets")
	local jdtl_keys = {
		{
			mode = { "n", "v" },
			{
				"<leader>gt",
				function()
					require("jdtls.tests").goto_subjects()
				end,
				desc = "Go to test",
			},
			{
				"<leader>oi",
				function()
					jdtls.organize_imports()
				end,
				desc = "Organize Imports",
			},
			{
				"<leader>jc",
				function()
					jdtls.compile("incremental")
				end,
				desc = "Compile Incremental",
			},
			{
				",tt",
				function()
					require("jdtls.dap").pick_test()
				end,
				desc = "Prompt for a test method",
			},
			{
				"<leader>dh",
				function()
					dap_widget.hover()
				end,
				desc = "Debug hover",
			},
			{
				"<leader>dp",
				function()
					dap_widget.preview()
				end,
				desc = "Debug preview",
			},
			{
				"<leader>df",
				function()
					dap_widget.centered_float(dap_widget.frames)
				end,
				desc = "Debug frames",
			},
			{
				"<leader>ds",
				function()
					dap_widget.centered_float(dap_widget.scopes)
				end,
				desc = "Debug scopes",
			},
		},
	}

	return vim.list_extend(lsp_common_keys, jdtl_keys)
end

function P.search_keys()
	return {
		-- Telescope
		{
			mode = { "n", "v" },
			{ "<leader>b", telescope_builtin.buffers, desc = "Search for buffers" },
			{ "<leader>of", telescope_builtin.oldfiles, desc = "Old files" },
			{
				"<leader>/",
				function()
					-- You can pass additional configuration to telescope to change theme, layout, etc.
					telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end,
				desc = "Fuzzy find in current buffer",
			},
			{ "<leader>fs", telescope_builtin.lsp_document_symbols, desc = "File symbols" },
			{ "<space>ts", telescope_builtin.treesitter, desc = "Telescope treesitter picker" },
			{ "<leader>ff", telescope_builtin.find_files, desc = "Search for file" },
			{ "<leader>ht", telescope_builtin.help_tags, desc = "Search help" },
			{ "<leader>gs", telescope_builtin.grep_string, desc = "Search for selection in files" },
			{ "<leader>lg", telescope_builtin.live_grep, desc = "Live grep" },
			{
				"<leader>fc",
				function()
					telescope_builtin.find_files({
						prompt_title = "Neovim Config Files",
						cwd = os.getenv("HOME") .. "/nvim-workflow-config/nvim/",
						hidden = true,
						no_ignore = true,
					})
				end,
				desc = "Search Neovim configuration files",
			},
			{ "<leader>ch", telescope_builtin.command_history, desc = "Command history" },
		},
	}
end

function P.other_keys()
	return {
		{
			-- Quickfix list navigation
			mode = { "n", "v" },
			{ "<c-n>", ":cnext<CR>", desc = "Next quick fix item" },
			{ "<c-p>", ":cprevious<CR>", desc = "Previous quick fix item" },
			{ "<leader>wd", ":NvimTreeFindFileToggle<CR>", desc = "NvimTreeFindFileToggle" },
		},
	}
end

return P
