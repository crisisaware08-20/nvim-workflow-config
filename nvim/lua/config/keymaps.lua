-- Tmux-aware navigation: Ctrl+h/j/k/l to navigate between splits and tmux panes
-- If at edge of vim splits, pass through to tmux
local function navigate(direction)
	local win_before = vim.fn.winnr()
	vim.cmd('wincmd ' .. direction)
	local win_after = vim.fn.winnr()

	-- If we didn't move (at edge), send command to tmux
	if win_before == win_after then
		local tmux_direction = ({
			h = 'L',
			j = 'D',
			k = 'U',
			l = 'R'
		})[direction]
		vim.fn.system('tmux select-pane -' .. tmux_direction)
	end
end

vim.keymap.set('n', '<C-h>', function() navigate('h') end, { desc = 'Navigate left', silent = true })
vim.keymap.set('n', '<C-j>', function() navigate('j') end, { desc = 'Navigate down', silent = true })
vim.keymap.set('n', '<C-k>', function() navigate('k') end, { desc = 'Navigate up', silent = true })
vim.keymap.set('n', '<C-l>', function() navigate('l') end, { desc = 'Navigate right', silent = true })

-- Quick list navigation
vim.keymap.set('n', ']q',
	function()
		if not pcall(vim.cmd, 'cnext') then vim.cmd('cfirst') end
		vim.cmd('normal! zvzz')
	end, { desc = 'Quickfix next (wrap)' })
vim.keymap.set('n', '>>', '<Cmd>cnext<CR>', { desc = 'Quickfix: next' })
vim.keymap.set('n', '<<', '<Cmd>cprevious<CR>', { desc = 'Quickfix: prev' })
vim.keymap.set('n', ']l', '<Cmd>lnext<CR>', { desc = 'Loclist: next' })
vim.keymap.set('n', '[l', '<Cmd>lprevious<CR>', { desc = 'Loclist: prev' })

-- One liner execution, TJ's source
vim.keymap.set("n", "<leader>x", function()
	local line = vim.api.nvim_get_current_line()
	vim.cmd("lua " .. line)
end, { desc = "Run current Lua line" })

-- Explore directory
vim.keymap.set('n', '<leader>e', '<Cmd>Explore<CR>', { desc = 'Explore' })
