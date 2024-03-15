local wk = require("which-key")

-- Gitsign
require('gitsigns').setup {
	signs = {
		add          = { text = '+' },
		change       = { text = '~' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true
	},
	-- auto_attach = true,
	-- one more
	-- two more
	peview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	on_attach = function (bufnr)

		local gs = package.loaded.gitsigns
		local builtin = require('telescope.builtin')

		wk.register({
			["g"] = {
				name = "Git",
				k = { gs.prev_hunk, "Prev Hunk" },
				j = { gs.next_hunk, "Next Hunk" },
				l = { gs.blame_line, "Blame" },
				p = { gs.preview_hunk, "Preview Hunk" },
				r = { gs.reset_hunk, "Reset Hunk" },
				R = { gs.reset_buffer, "Reset Buffer" },
				s = { gs.stage_hunk, "Stage Hunk" },
				u = { gs.undo_stage_hunk, "Undo Stage Hunk" },
				o = { builtin.git_status, "Open changed file"},
				b = { builtin.git_branches, "Checkout branch" },
				c = { builtin.git_commits, "Checkout commit" },
				d = { gs.diffthis, "Diff"},
			},
		})

	end

}
