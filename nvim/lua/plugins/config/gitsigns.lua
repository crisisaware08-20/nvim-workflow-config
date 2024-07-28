
-- Gitsign
require('gitsigns').setup {
	signs          = {
		add          = { text = '+' },
		change       = { text = '~' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn     = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl          = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl         = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff      = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir   = {
		follow_files = true
	},
	-- auto_attach = true,
	-- one more
	-- two more
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	on_attach      = function(bufnr)
		local gs = require('gitsigns')
		local builtin = require('telescope.builtin')
		local wk = require("which-key")


		wk.add({
			{ "<leader>G", group = "GitSigns", expand = function ()
				 return require("which-key.extras").expand.buf()
			end },
			{ "gk",        gs.prev_hunk,         desc = "Prev Hunk" },
			{ "gj",        gs.next_hunk,         desc = "Next Hunk" },
			{ "gl",        gs.blame_line,        desc = "Blame" },
			{ "gp",        gs.preview_hunk,      desc = "Preview Hunk" },
			{ "gr",        gs.reset_hunk,        desc = "Reset Hunk" },
			{ "gR",        gs.reset_buffer,      desc = "Reset Buffer" },
			{ "gs",        gs.stage_hunk,        desc = "Stage Hunk" },
			{ "gu",        gs.undo_stage_hunk,   desc = "Undo Stage Hunk" },
			{ "go",        builtin.git_status,   desc = "Open changed file" },
			{ "gb",        builtin.git_branches, desc = "Checkout branch" },
		})
	end

}
