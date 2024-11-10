local prompts = {
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

local chat = require("CopilotChat")
local select = require("CopilotChat.select")


local keys = {
	-- Show help actions with telescope
	{
		"<leader>cch",
		function()
			local actions = require("CopilotChat.actions")
			require("CopilotChat.integrations.telescope").pick(actions.help_actions())
		end,
		desc = "CopilotChat - Help actions",
	},
	-- Show prompts actions with telescope
	{
		"<leader>ccp",
		function()
			local actions = require("CopilotChat.actions")
			require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
		end,
		desc = "CopilotChat - Prompt actions",
	},

}


local opts = {
	debug = true,    -- Enable debugging
	show_help = true, -- Show help actions
	window = {
		layout = "float",
	},
	auto_follow_cursor = false, -- Don't follow the cursor after getting response

	prompts = {
		Execute = {
			prompt = "Provide accurate response on what is being asked.",
			selection = select.visual,
		},
		-- Wording = {
		-- 	prompt = 'Please improve the grammar and wording of the following text.',
		-- 	description = 'Prompt to command',
		-- 	selection = require('CopilotChat.select').visual,
		-- },
	},
}

-- Use unnamed register for the selection
opts.selection = select.unnamed

-- Override the git prompts message
opts.prompts.Commit = {
	prompt = "Write commit message for the change with commitizen convention",
	selection = select.gitdiff,
}

opts.prompts.CommitStaged = {
	prompt = "Write commit message for the change with commitizen convention",
	selection = function(source)
		return select.gitdiff(source, true)
	end,
}

chat.setup(opts)

-- Setup the CMP integration
require("CopilotChat.integrations.cmp").setup()

vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
	chat.ask(args.args, { selection = select.visual })
end, { nargs = "*", range = true })

-- This command is to test copilot chat api
vim.api.nvim_create_user_command("TestCopilotChat",
	function(args)
		-- Open chat window with custom options
		chat.open({
			window = {
				layout = 'float',
				title = 'My Title',
			},
		})
	end,
	{ nargs = "*", range = true })


-- vim.api.nvim_create_user_command("AskCopilot", function(args)
--
-- 	-- local input = vim.fn.input
--
-- end
-- )
