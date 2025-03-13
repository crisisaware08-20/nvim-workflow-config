require("copilot").setup {
	suggestion = { enabled = false },
	panel = {
		enabled = false ,
	},
	cmp = {
		enabled = true,
		method = "getCompletionsCycling",
	},
	-- Other configurations
}
