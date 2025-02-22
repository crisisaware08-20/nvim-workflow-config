require('package-manager').boot_lazy_packg_manager()
require('lazy').setup(require("plugins/to_install"), opts)
require('plugins/to_config')

-- Auto-save when leaving insert mode or after inactivity
vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHold" }, {
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent write")
    end
  end,
})

-- Map <Esc> to save the file as well as exit insert mode
vim.keymap.set({"i", "n"}, "<Esc>", function()
  if vim.bo.modified then
    vim.cmd("silent write")
  end
  return "<Esc>"
end, { expr = true, noremap = true })

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

-- CopilotChat mappings
vim.keymap.set('n', '<Space>o', '<cmd>CopilotChatOpen<cr>')
vim.keymap.set('n', '<Space>t', '<cmd>CopilotChatToggle<cr>')
vim.keymap.set('n', '<Space><CR>', '<cmd>CopilotChatExecute<cr>')

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
function change_working_dir()
	require('util-module').change_nvim_directory_to(vim.fn.expand('%:p:h'))
	require('nvim-tree.api').tree.change_root(vim.fn.getcwd())
end
vim.keymap.set('n', '<leader>cd', change_working_dir, { noremap = true, silent = true })


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
vim.opt.hidden = true
vim.opt.tabstop = 2
-- vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.timeoutlen = 40
vim.cmd([[
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if !&nu | set nu   |set rnu   | endif
autocmd BufLeave,FocusLost,WinLeave   * if &nu              | set nonu |set nornu |  endif
augroup END
]])
