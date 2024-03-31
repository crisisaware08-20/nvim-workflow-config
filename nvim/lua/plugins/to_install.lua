return {

	-- Table and DrawIt
	{
		"vim-scripts/DrawIt", "dhruvasagar/vim-table-mode"
	},

	{
		"ribru17/bamboo.nvim"
	},

	-- Noice
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- },

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
	},

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
		"folke/tokyonight.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},

	-- Git
	{
		"tpope/vim-fugitive",
		"lewis6991/gitsigns.nvim"
	},

	-- LSP servers, DAP servers, linters, and formatters
	-- Mason and nvim lsp integration
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig"
	},

	-- Java lsp client wrapper
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" }
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim", "nvim-telescope/telescope-ui-select.nvim" }
	},


	-- I don't know yet what this is used for
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require 'lsp_signature'.setup(opts) end
	},

	-- Status line
	{
		"famiu/feline.nvim"
	},

	{
		"terrortylor/nvim-comment"
	},


	-- Get lost with mapping ? Unload your mental model of mappings to this friendly plugin
	 {
	 	'folke/which-key.nvim'
	 },

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end
	},

	{
		"folke/zen-mode.nvim",
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},

	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }
	},

}
