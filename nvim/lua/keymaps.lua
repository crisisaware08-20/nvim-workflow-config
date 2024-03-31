local P = {}
keymaps = P


local builtin = require('telescope.builtin')
local wk = require("which-key")
local lsp = vim.lsp.buf


local key_map = function(mode, key, result, desc)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true, desc = desc })
end

-- nvim-lspconfig
function P.lsp_keys()
	wk.register({
		["g"] = {
			name = "LSP - default key maps",
			d = { lsp.definition, "Go to definition" },
			D = { lsp.declaration, "Go to declaration" },
			i = { lsp.implementation, "Go to implementation" },
			t = { lsp.type_definition, "Jumps to the definition of the type of the symbol under the cursor" }
		}
	})
	key_map('n', '<leader>sr', ':lua require("telescope.builtin").lsp_references()<CR>', "[S]how [r]eferences of suc")
	key_map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
	key_map('x', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
	key_map('n', '<leader>re', ':lua vim.lsp.buf.rename()<CR>')
	key_map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
	key_map('n', '<leader>cf', ':lua vim.lsp.buf.format()<CR>')
	key_map('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>')
	key_map('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>')
	key_map('n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
	key_map('n', '<space>e', ':lua vim.diagnostic.open_float()')
	key_map('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>')
	key_map('n', ']d', ':lua vim.diagnostic.goto_next()<CR>')
	key_map('n', '<space>q', ':lua vim.diagnostic.setloclist()')
end

function P.jdtls_keys(bufnr)
	P.lsp_keys()
	key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
	-- key_map('n', '<leader>ev', ':lua require("jdtls").extract_variable()<CR>') conflicts with init.lua
	key_map('n', '<leader>em', ':lua require("jdtls").extract_method()<CR>')
	key_map('x', '<leader>em', ':lua require("jdtls").extract_method(true)<CR>')
	key_map('x', '<leader>ev', ':lua require("jdtls").extract_variable(true)<CR>')
	key_map('n', '<leader>jc', ':lua require("jdtls").compile("incremental")')

	-- If using nvim-dap
	-- This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
	-- nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
	-- nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
	key_map('n', ',r', ':lua require("jdtls").test_nearest_method()<CR>')
	key_map('n', ',c', ':lua require("jdtls").test_class()<CR>')
end

function P.hop()
	key_map('n', '<leader><leader>w', '<cmd>HopWord<CR>')
end

function P.telescope()
	vim.keymap.set('n', '<leader>b', builtin.buffers, {})
	vim.keymap.set('n', '<S-e>', require('telescope.builtin').oldfiles, { desc = '[S-e] Find recently opened files' })
	vim.keymap.set('n', '<leader>/', function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			winblend = 10,
			previewer = false,
		}, { desc = '[<leader>/] Fuzzy find in current buffer' })
	end, { desc = '[/] Fuzzily search in current buffer]' })
	vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = '[F]File structure' })
	vim.keymap.set('n', ';', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
end

function P.treesitter()
	-- Treesitter text-objects gotos
	vim.keymap.set('n', 'np', '<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>')
	vim.keymap.set('n', 'pp', '<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>')
	vim.keymap.set('n', 'nc', '<cmd>TSTextobjectGotoNextStart @call.outer<CR>')
	vim.keymap.set('n', 'pc', '<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>')
	vim.keymap.set('n', 'nic', '<cmd>TSTextobjectGotoNextStart @call.inner<CR>')
	vim.keymap.set('n', 'pic', '<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>')
	vim.keymap.set('n', 'nf', '<cmd>TSTextobjectGotoNextStart @function.inner<CR>')
	vim.keymap.set('n', 'pf', '<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>')
	vim.keymap.set('n', 'nb', '<cmd>TSTextobjectGotoNextStart @block.outer<CR>')
	vim.keymap.set('n', 'pb', '<cmd>TSTextobjectGotoPreviousStart @block.outer<CR>')
end

vim.keymap.set('n', "<leader>w", "<CMD>NvimTreeFindFileToggle<cr>")

return P
