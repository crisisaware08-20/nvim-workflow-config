require('package-manager').boot_lazy_packg_manager()

require('lazy').setup(require("plugins/to_install"), opts)

require('plugins/to_config')

-- Mappings based on custom functions, this could be refactored later when util-module will evolve to certain point
-- mappings could be passed to a setup function, check other plugins .....
vim.api.nvim_set_keymap('n', '<leader><leader>m', ':lua require("util-module").ResizeBufferTop()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>r', ':lua require("util-module").RestoreOriginalSize()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cd', 
[[:lua require('util-module').change_nvim_directory_to(vim.fn.expand('%:p:h'))<CR>]],
{ noremap = true, silent = true })

-- Basic Mappings
vim.keymap.set('n', '<leader>b', ':buffers<CR>:buffer<Space>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>w', ':Explore<CR>')
vim.keymap.set('n', '<leader>sv', '<cmd>source ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>ev', '<cmd>hide e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>sz', '<cmd>!source ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>ez', '<cmd>hide e ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>f', 'gg=G')
vim.keymap.set('n', '<leader>wo', '<c-w>o', { noremap = true, silent = false })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true, silent = false })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true, silent = false })
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true, silent = false })
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>l', '<c-w><S-l>', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>h', '<c-w><S-h>', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>k', '<c-w><S-k>', { noremap = true, silent = false })
vim.keymap.set('n', '<Tab>j', '<c-w><S-j>', { noremap = true, silent = false })
vim.keymap.set('n', 'qw', '<c-w>c', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>q', ':cclose<CR>', { noremap = true, silent = true })


-- Commands
vim.api.nvim_command('filetype plugin on')
vim.api.nvim_command('colorscheme tokyonight-moon')

-- Options
vim.opt.clipboard='unnamedplus'
vim.opt.path:append  '**'
vim.opt.path:append(os.getenv('HOME') .. '/vim-configuration/nvim/**') -- Offer access to nvim primary configurations files
vim.opt.hidden=true
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.tabstop=1
vim.opt.shiftwidth=1
vim.opt.timeoutlen=100
