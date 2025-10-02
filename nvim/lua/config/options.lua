-- add to cwd ** so that it could find recursively without specifying the relative path 
vim.opt.path:append({"**", "/usr/include"})

-- sharing same clipboard
vim.opt.clipboard="unnamedplus"

-- key mappings
vim.keymap.set('n', ']q', function() if not pcall(vim.cmd, 'cnext') then vim.cmd('cfirst') end vim.cmd('normal! zvzz') end, {desc = 'Quickfix next (wrap)'})
vim.keymap.set('n', '>>', '<Cmd>cnext<CR>',     { desc = 'Quickfix: next' })
vim.keymap.set('n', '<<', '<Cmd>cprevious<CR>', { desc = 'Quickfix: prev' })
vim.keymap.set('n', ']l', '<Cmd>lnext<CR>',     { desc = 'Loclist: next' })
vim.keymap.set('n', '[l', '<Cmd>lprevious<CR>', { desc = 'Loclist: prev' })
vim.keymap.set("n", "<leader>x", function()
  local line = vim.api.nvim_get_current_line()
  vim.cmd("lua " .. line)
end, { desc = "Run current Lua line" })


-- grep options
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
	-- %f - filename where the match was found
	-- %l - line number of the match
	-- %c - column number of the match
	-- %m - text of the matched line


-- fold options
vim.opt.foldmethod='indent'
	-- za : Toggle the fold under the cursor (open if closed, close if open).
	-- zR : Open all folds in the file.
	-- zM : Close all folds in the file.
	-- zc : Close the fold under the cursor.
	-- zo : Open the fold under the cursor.


vim.opt.foldlevel=99


