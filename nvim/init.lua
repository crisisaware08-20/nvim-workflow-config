require('package-manager').boot_lazy_packg_manager()

require('lazy').setup(require("plugins/to_install"), opts)

require('plugins/to_config')


-- Mappings based on custom functions, this could be refactored later when util-module will evolve to certain point
-- mappings could be passed to a setup function, check other plugins .....
vim.api.nvim_set_keymap('n', '<leader><leader>m', ':lua require("util-module").ResizeBufferTop()<CR>',
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>r', ':lua require("util-module").RestoreOriginalSize()<CR>',
	{ noremap = true, silent = true })
vim.keymap.set('n', '<leader>cd', [[:lua require('util-module').change_nvim_directory_to(vim.fn.expand('%:p:h'))<CR>]],
	{ noremap = true, silent = true })


-- Jump forward or backward
vim.api.nvim_set_keymap('i', '<C-k>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<C-k>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<C-j>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], { expr = true, noremap = true, silent = true })


-- TS movements
vim.keymap.set('n', '<Space>p', '<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>', { desc = 'next parameter inner' })
vim.keymap.set('n', '<Tab>p', '<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>', { desc = 'previous parameter inner' })
vim.keymap.set('n', '<Space>c', '<cmd>TSTextobjectGotoNextStart @call.outer<CR>', { desc = 'next call outer' })
vim.keymap.set('n', '<Tab>c', '<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>', { desc = 'previous call outer' })
vim.keymap.set('n', '<Space>ic', '<cmd>TSTextobjectGotoNextStart @call.inner<CR>', { desc = 'next call inner' })
vim.keymap.set('n', '<Tab>ic', '<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>', { desc = 'previous call inner' })
-- vim.keymap.set('n', '<Space>f', '<cmd>TSTextobjectGotoNextStart @function.inner<CR>', { desc = 'next function inner' })
-- vim.keymap.set('n', '<Tab>f', '<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>', { desc = 'previous function inner' })
vim.keymap.set('n', '<Tab><Tab>', '<cmd>TSTextobjectGotoNextStart @block.outer<CR>', { desc = 'next block outer' })
vim.keymap.set('n', '<Tab>b', '<cmd>TSTextobjectGotoPreviousStart @block.outer<CR>', { desc = 'previous block outer' })


-- Basic Mappings
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

vim.api.nvim_command(':set nohls')

vim.diagnostic.config({ virtual_text = false })


-- Options
vim.opt.clipboard = 'unnamedplus'
vim.opt.path:append '**'
vim.opt.path:append(os.getenv('HOME') .. '/vim-configuration/nvim/**') -- Offer access to nvim primary configurations files
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.timeoutlen = 100
vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if !&nu | set nu   |set rnu   | endif
  autocmd BufLeave,FocusLost,WinLeave   * if &nu              | set nonu |set nornu |  endif
augroup END
]])
