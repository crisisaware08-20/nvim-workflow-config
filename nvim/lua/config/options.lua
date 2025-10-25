-- add to cwd ** so that it could find recursively without specifying the relative path 
vim.opt.path:append({"**", "/usr/include", "/Users/mihai.iurcomgmail.com/github/nvim-workflow-config/**"})

-- sharing same clipboard
vim.opt.clipboard="unnamedplus"

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


