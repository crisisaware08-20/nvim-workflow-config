return {

	-- { "github/copilot.vim" },

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				server_opts_overrides = {
					trace = "verbose",
					settings = {
						advanced = {
							listCount = 5,   -- #completions for panel
							inlineSuggestCount = 3, -- #completions for getCompletions
						}
					},
				}
			})
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
	},

	{ "andrewferrier/wrapping.nvim" },

	-- Table and DrawIt
	{
		"vim-scripts/DrawIt",
		"dhruvasagar/vim-table-mode"
	},

	-- Like IDE within terminal
	{
		'akinsho/toggleterm.nvim',
		lazy = false,
		version = "*",
		opts = {
			["open_mapping"] = [[<c-\>]]
		},
		direction = 'vertical'
	},

	-- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
	-- TODO: configure
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" }
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
		dependencies = { "nvim-tree/nvim-web-devicons" }
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
		{
			"zbirenbaum/copilot-cmp",
			config = function()
				require("copilot_cmp").setup()
			end,
			-- dependencies = {
			-- 	"zbirenbaum/copilot.lua",
			-- 	cmd = "Copilot",
			-- 	config = function()
			-- 		require("copilot").setup({
			-- 			suggestion = { enabled = true },
			-- 			panel = { enabled = true },
			-- 		})
			-- 	end,
			-- },
		},
		"rafamadriz/friendly-snippets"
	},


	-- Color schemes
	{
		"folke/tokyonight.nvim",
		"ribru17/bamboo.nvim",
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
		'folke/which-key.nvim',
		lazy = true,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		dependencies = { 'echasnovski/mini.nvim' }
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

	{
		'sbdchd/neoformat'
	}

}
