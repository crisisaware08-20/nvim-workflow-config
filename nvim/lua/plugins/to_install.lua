return {

	-- Completion
	{
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"tamago324/cmp-zsh",
		"rafamadriz/friendly-snippets"
	},

	-- Color scheme
	{
		"folke/tokyonight.nvim"
	},

	-- Git
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim"
	},

	-- LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim"
	},

	-- Java lsp client wrapper
	{
		"mfussenegger/nvim-jdtls"
	},

	-- Mason and nvim lsp integration
	{
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig"
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},


	-- I don't know yet what this is used for
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require'lsp_signature'.setup(opts) end
	},

	-- Buffers and Quick list navigation
	{
		"tpope/vim-unimpaired"
	},

	-- Hop
	{
		'smoka7/hop.nvim',
		version = "*",
		opts = {},
	},

	-- Status line
	{
		"famiu/feline.nvim"
	},

	{
		"terrortylor/nvim-comment"
	},

}
