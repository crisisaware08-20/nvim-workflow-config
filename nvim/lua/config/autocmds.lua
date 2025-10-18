
vim.api.nvim_create_autocmd('LspAttach', {
	-- Default keymaps can be overriden here 
	callback = function(event)
		print(print(string.format('event fired: %s', vim.inspect(event))))
	end
})
