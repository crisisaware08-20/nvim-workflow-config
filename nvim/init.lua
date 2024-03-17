require('package-manager').boot_lazy_packg_manager()

require('lazy').setup(require("plugins/to_install"), opts)

require('plugins/to_config')

-- Mappings based on custom functions, this could be refactored later when util-module will evolve to certain point
-- mappings could be passed to a setup function, check other plugins .....
vim.api.nvim_set_keymap('n', '<leader><leader>m', ':lua require("util-module").ResizeBufferTop()<CR>',
{ noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>r', ':lua require("util-module").RestoreOriginalSize()<CR>',
{ noremap = true, silent = true })
vim.keymap.set('n', '<leader>cd',
[[:lua require('util-module').change_nvim_directory_to(vim.fn.expand('%:p:h'))<CR>]],
{ noremap = true, silent = true })

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


vim.api.nvim_command('filetype plugin on')

-- Colorscheme
-- vim.api.nvim_command('colorscheme tokyonight-moon')
vim.api.nvim_command('colorscheme bamboo')

-- Auto save buffer
vim.api.nvim_command(':set autowriteall')

vim.diagnostic.config({ virtual_text = false })

-- Options
vim.opt.clipboard = 'unnamedplus'
vim.opt.path:append '**'
vim.opt.path:append(os.getenv('HOME') .. '/vim-configuration/nvim/**') -- Offer access to nvim primary configurations files
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 1
vim.opt.shiftwidth = 1
vim.opt.timeoutlen = 100
