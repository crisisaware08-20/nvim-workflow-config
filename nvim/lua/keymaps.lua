local P = {}
keymaps = P

local key_map = function(mode, key, result)
	vim.api.nvim_set_keymap( mode, key, result, {noremap = true, silent = true})
end


-- nvim-lspconfig
function P.map_lsp_keys()
	key_map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
	key_map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
	key_map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
	key_map('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
	key_map('n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>')

	key_map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
	key_map('x', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')

	key_map('n', '<leader>re', ':lua vim.lsp.buf.rename()<CR>')

	key_map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
	key_map('n', '<leader>cf', ':lua vim.lsp.buf.format()<CR>')

	key_map('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>')
	key_map('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>')
	key_map('n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

end

-- nvim-jdtls
function P.map_java_keys(bufnr)
	P.map_lsp_keys()
	key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
	-- key_map('n', '<leader>ev', ':lua require("jdtls").extract_variable()<CR>') conflicts with init.lua
	key_map('n', '<leader>em', ':lua require("jdtls").extract_method()<CR>')
	key_map('x', '<leader>em', ':lua require("jdtls").extract_method(true)<CR>')
	key_map('x', '<leader>ev', ':lua require("jdtls").extract_variable(true)<CR>')
	key_map('n', '<leader>jc', ':lua require("jdtls").compile("incremental")')

	-- If using nvim-dap
	-- This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
	--nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
	--nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>
end

-- hop
function P.map_hop()
	key_map('n', '<leader>hp', '<cmd>HopPattern<CR>')
	key_map('n', 'gt', '<cmd>HopLine<CR>')
	key_map('n', '<leader><leader>w', '<cmd>HopWord<CR>')
end

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<S-e>', require('telescope.builtin').oldfiles, { desc = '[S-e] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  }, {desc = '[<leader>/] Fuzzy find in current buffer'})
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', ';', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set("n", "<Leader>sr", "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", silent)
-- vim.keymap.set("n", "<Leader>sR", "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", silent)
-- vim.keymap.set("n", "<Leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", silent)

-- nvim-tree

vim.keymap.set('n', "<leader>w", "<CMD>NvimTreeFindFileToggle<cr>")

return P
