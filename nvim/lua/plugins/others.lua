
return {

	-- I don't know yet what this is used for
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require'lsp_signature'.setup(opts) end
	}, 

	-- Buffers and Quick list navigation
	{ "tpope/vim-unimpaired" },

	-- Hop
	{
		'smoka7/hop.nvim',
		version = "*",
		opts = {},
	}

}


