require("package-manager").boot_lazy_packg_manager()
local plugins = require("plugins/to_install")
require("lazy").setup(plugins)
require("plugins/to_config").setup()

-- Auto-save when leaving insert mode or after inactivity
vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHold" }, {
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent write")
		end
	end,
})

vim.api.nvim_command("filetype plugin on")

-- Colorscheme
-- vim.api.nvim_command('colorscheme tokyonight-moon')
vim.api.nvim_command("colorscheme bamboo")

-- Auto save buffer
vim.api.nvim_command(":set autowriteall")

-- vim.api.nvim_command(":let &statusline='%#Normal# '")
vim.api.nvim_command(":let &statusline='%f'")
vim.api.nvim_command(":let &laststatus=2")
vim.api.nvim_command(":set nohls")

vim.diagnostic.config({ virtual_text = false })

-- Options
vim.opt.clipboard = "unnamedplus"
vim.opt.hidden = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.timeoutlen = 40
vim.cmd([[
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if !&nu | set nu   |set rnu   | endif
autocmd BufLeave,FocusLost,WinLeave   * if &nu              | set nonu |set nornu |  endif
augroup END
]])
