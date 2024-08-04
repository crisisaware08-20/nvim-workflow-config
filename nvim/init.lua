require('package-manager').boot_lazy_packg_manager()

require('lazy').setup(require("plugins/to_install"), opts)

require('plugins/to_config')

vim.api.nvim_set_keymap('n', 'j', 'gj^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk^', { noremap = true, silent = true })

-- Mappings based on custom functions, this could be refactored later when util-module will evolve to certain point
-- mappings could be passed to a setup function, check other plugins .....
vim.api.nvim_set_keymap('n', '<leader><leader>m', ':lua require("util-module").ResizeBufferTop()<CR>',
	{ noremap = true, silent = true , desc = "Maximize Current Buffer"})
vim.api.nvim_set_keymap('n', '<leader><leader>r', ':lua require("util-module").RestoreOriginalSize()<CR>',
	{ noremap = true, silent = true , desc = "Restore Buffer View"})
vim.keymap.set('n', '<leader>cd', [[:lua require('util-module').change_nvim_directory_to(vim.fn.expand('%:p:h'))<CR>]],
	{ noremap = true, silent = true })

-- Terminal window navigation
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<c-k>', [[<C-\><C-N><C-w>k]])
vim.keymap.set('i', '<c-k>', [[<C-\><C-N><C-w>k]])
vim.keymap.set('t', '<c-h>', [[<C-\><C-N><C-w>h]])
vim.keymap.set('i', '<c-h>', [[<C-\><C-N><C-w>h]])
vim.keymap.set('t', '<c-l>', [[<C-\><C-N><C-w>l]])
vim.keymap.set('i', '<c-l>', [[<C-\><C-N><C-w>l]])
vim.keymap.set('t', '<c-j>', [[<C-\><C-N><C-w>j]])
vim.keymap.set('i', '<c-j>', [[<C-\><C-N><C-w>j]])

-- Snippets - Jump forward or backward
vim.api.nvim_set_keymap('i', '<C-k>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
	{ expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<C-k>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']],
	{ expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
	{ expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<C-j>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']],
	{ expr = true, noremap = true, silent = true })


-- Basic Mappings
vim.keymap.set('n', '<leader>te', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('n', '<leader>ev', '<cmd>hide e ~/.config/nvim/init.lua<CR>', { desc = '[E]dit init.lua' })
vim.keymap.set('n', '<leader>sz', '<cmd>!source ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>ez', '<cmd>hide e ~/.zshrc<CR>')
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true, silent = false })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true, silent = false })
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true, silent = false })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>l', '<c-w><S-l>', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>h', '<c-w><S-h>', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>k', '<c-w><S-k>', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>j', '<c-w><S-j>', { noremap = true, silent = false })
vim.keymap.set('n', 'qw', '<c-w>c', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>q', ':cclose<CR>', { noremap = true, silent = true, desc = 'Close quick list' })
vim.keymap.set('n', '<S-l>', '<c-w>>', { noremap = true, silent = false })
vim.keymap.set('n', '<S-h>', '<c-w><', { noremap = true, silent = false })
vim.keymap.set('n', '<S-e>', '<c-w>+', { noremap = true, silent = false })
vim.keymap.set('n', '<S-y>', '<c-w>-', { noremap = true, silent = false })
vim.keymap.set('n', 'tl', '', {
	noremap = true,
	silent = true,
	callback = function()
		vim.cmd('set number!')
		vim.cmd('set relativenumber!')
	end
})


vim.api.nvim_command('filetype plugin on')

-- Colorscheme
-- vim.api.nvim_command('colorscheme tokyonight-moon')
vim.api.nvim_command('colorscheme bamboo')

-- Auto save buffer
vim.api.nvim_command(':set autowriteall')

-- vim.api.nvim_command(":let &statusline='%#Normal# '")
vim.api.nvim_command(":let &statusline='%f'")
vim.api.nvim_command(":let &laststatus=2")
vim.api.nvim_command(':set nohls')

vim.diagnostic.config({ virtual_text = false })


-- Options
vim.opt.clipboard = 'unnamedplus'
-- Disable it due to the lagging effect when invoking :find command for directories with lot of files in it.
--
-- The scope of :find command is to search for nvim config workspace
-- The scope of Telescope is to search for files in nvim current directory 
--
-- Todo: Add nvim config workspace to search path for Telescope
--
-- vim.opt.path:append '**'
vim.opt.path:append(os.getenv('HOME') .. '/nvim-workflow-config/nvim/**') -- Offer access to nvim primary configurations files
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
