require("CopilotChat").setup {
	debug = false, -- Enable debug logging



	prompts = {
		MyCustomPrompt = {
			prompt = 'Explain how it works.',
			mapping = '<leader>ccmc',
			description = 'My custom prompt description',
			selection = require('CopilotChat.select').visual,
		},
	},

	-- default mappings
	mappings = {
		complete = {
			detail = 'Use @<Tab> or /<Tab> for options.',
			insert = '<Tab>',
		},
		close = {
			normal = 'q',
			insert = '<C-c>'
		},
		reset = {
			normal = '<C-x>',
			insert = '<C-x>'
		},
		submit_prompt = {
			normal = '<CR>',
			insert = '<C-s>'
		},
		accept_diff = {
			normal = '<C-y>',
			insert = '<C-y>'
		},
		yank_diff = {
			normal = 'gy',
		},
		show_diff = {
			normal = 'gd'
		},
		show_system_prompt = {
			normal = 'gp'
		},
		show_user_selection = {
			normal = 'gs'
		},
	},
}
