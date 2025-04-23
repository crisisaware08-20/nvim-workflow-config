require("copilot").setup({
	suggestion = { enabled = true },
	panel = {
		enabled = false,
	},
	cmp = {
		enabled = true,
		method = "getCompletionsCycling",
	},
	-- Other configurations
})
