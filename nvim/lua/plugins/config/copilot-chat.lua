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
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

local chat = require("CopilotChat")
local select = require("CopilotChat.select")

local opts = {
	debug = true, -- Enable debugging
	show_help = true, -- Show help actions
	window = {
		layout = "vertical",
	},
	auto_follow_cursor = false, -- Don't follow the cursor after getting response
	-- chat_auto_complete = true, -- Enable auto completion

	prompts = {
		Execute = {
			prompt = "Provide accurate response on what is being asked.",
			selection = select.visual,
		},
	},
}

chat.setup(opts)
