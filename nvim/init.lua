require('package-manager').add_lazy_to_nvim_rtp()

require('pluginconfigs')

require'keymaps'.map_hop()

-- Basic Mappings
vim.keymap.set('n', '<leader>b', ':buffers<CR>:buffer<Space>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>w', ':Explore<CR>')
vim.keymap.set('n', '<leader>sv', '<cmd>source ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>ev', '<cmd>hide e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>sz', '<cmd>!source ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>ez', '<cmd>hide e ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>f', 'gg=G')
vim.keymap.set('n', '<leader>wo', '<c-w>o', { noremap = true, silent = false })
vim.keymap.set('n', 'qw', '<c-w>c', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>cd', 
                    [[:lua require('util-module').change_nvim_directory_to(vim.fn.expand('%:p:h'))<CR>]],
																				{ noremap = true, silent = true })

-- Commands
vim.api.nvim_command('filetype plugin on')
vim.api.nvim_command('colorscheme tokyonight-moon')

-- Options
vim.opt.clipboard='unnamedplus' -- Share Nvim clipboard with system clipboard.
vim.opt.path:append  '**' -- Append to current path current directory and its subdirectories.
vim.opt.hidden=true
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.tabstop=1
vim.opt.shiftwidth=1
--vim.opt.timeoutlen=100

-- Delete when the find will search in all subdirectories of the root directory
-- util_module.print_path_option()
