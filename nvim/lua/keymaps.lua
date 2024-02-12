local P = {}
keymaps = P

local key_map = function(mode, key, result)
	vim.api.nvim_set_keymap( mode, key, result, {noremap = true, silent = true})
end


--LSP
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

-- Java
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

-- Hop
function P.map_hop()
	key_map('n', '<leader>hp', '<cmd>HopPattern<CR>')
	key_map('n', 'gt', '<cmd>HopLine<CR>')
	key_map('n', '<leader><leader>w', '<cmd>HopWord<CR>')
end

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
return P
