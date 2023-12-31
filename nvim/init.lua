local lazymodule = require('lazy') -- Load the lazy.lua module
local mymodule = require('mymodule') -- Load mymodule, purley for experimenting
mymodule.say_hello()
mymodule.print_path_option()

-- Mappings
vim.api.nvim_set_keymap('n', '<leader>b', ':buffers<CR>:buffer<Space>', { noremap = true, silent = false })

vim.keymap.set('n', '<leader>w', ':Explore<CR>')
vim.keymap.set('n', '<leader>sv', '<cmd>source ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>ev', '<cmd>hide e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>sz', '<cmd>!source ~/.zshrc<CR>')
vim.keymap.set('n', '<leader>ez', '<cmd>hide e ~/.zshrc<CR>')


-- Options
vim.opt.clipboard='unnamedplus' -- Share Nvim clipboard with system clipboard.
vim.opt.path:append  '**' -- Append to current path current directory and its subdirectories.
vim.opt.hidden=true
vim.opt.number=true
vim.opt.relativenumber=true


